-- |
-- Module      : Crypto.ECC
-- License     : BSD-style
-- Maintainer  : Vincent Hanquez <vincent@snarc.org>
-- Stability   : experimental
-- Portability : unknown
--
-- Elliptic Curve Cryptography
--
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Crypto.ECC
    ( Curve_P256R1(..)
    , Curve_P384R1(..)
    , Curve_P521R1(..)
    , Curve_X25519(..)
    , Curve_X448(..)
    , Curve_Edwards25519(..)
    , EllipticCurve(..)
    , EllipticCurveDH(..)
    , EllipticCurveArith(..)
    , KeyPair(..)
    , SharedSecret(..)
    ) where

import qualified Crypto.PubKey.ECC.P256 as P256
import qualified Crypto.ECC.Edwards25519 as Edwards25519
import qualified Crypto.ECC.Simple.Types as Simple
import qualified Crypto.ECC.Simple.Prim as Simple
import           Crypto.Random
import           Crypto.Error
import           Crypto.Internal.Imports
import           Crypto.Internal.ByteArray (ByteArray, ByteArrayAccess, ScrubbedBytes)
import qualified Crypto.Internal.ByteArray as B
import           Crypto.Number.Serialize (i2ospOf_, os2ip)
import qualified Crypto.PubKey.Curve25519 as X25519
import qualified Crypto.PubKey.Curve448 as X448
import           Data.ByteArray (convert)
import           Data.Data (Data())
import           Data.Kind (Type)
import           Data.Proxy

-- | An elliptic curve key pair composed of the private part (a scalar), and
-- the associated point.
data KeyPair curve = KeyPair
    { keypairGetPublic  :: !(Point curve)
    , keypairGetPrivate :: !(Scalar curve)
    }

newtype SharedSecret = SharedSecret ScrubbedBytes
    deriving (Eq, ByteArrayAccess, NFData)

class EllipticCurve curve where
    -- | Point on an Elliptic Curve
    type Point curve  :: Type

    -- | Scalar in the Elliptic Curve domain
    type Scalar curve :: Type

    -- | Generate a new random scalar on the curve.
    -- The scalar will represent a number between 1 and the order of the curve non included
    curveGenerateScalar :: MonadRandom randomly => proxy curve -> randomly (Scalar curve)

    -- | Generate a new random keypair
    curveGenerateKeyPair :: MonadRandom randomly => proxy curve -> randomly (KeyPair curve)

    -- | Get the curve size in bits
    curveSizeBits :: proxy curve -> Int

    -- | Encode a elliptic curve point into binary form
    encodePoint :: ByteArray bs => proxy curve -> Point curve -> bs

    -- | Try to decode the binary form of an elliptic curve point
    decodePoint :: ByteArray bs => proxy curve -> bs -> CryptoFailable (Point curve)

class EllipticCurve curve => EllipticCurveDH curve where
    -- | Generate a Diffie hellman secret value.
    --
    -- This is generally just the .x coordinate of the resulting point, that
    -- is not hashed.
    --
    -- use `pointSmul` to keep the result in Point format.
    --
    -- /WARNING:/ Curve implementations may return a special value or an
    -- exception when the public point lies in a subgroup of small order.
    -- This function is adequate when the scalar is in expected range and
    -- contributory behaviour is not needed.  Otherwise use 'ecdh'.
    ecdhRaw :: proxy curve -> Scalar curve -> Point curve -> SharedSecret
    ecdhRaw prx s = throwCryptoError . ecdh prx s

    -- | Generate a Diffie hellman secret value and verify that the result
    -- is not the point at infinity.
    --
    -- This additional test avoids risks existing with function 'ecdhRaw'.
    -- Implementations always return a 'CryptoError' instead of a special
    -- value or an exception.
    ecdh :: proxy curve -> Scalar curve -> Point curve -> CryptoFailable SharedSecret

class (EllipticCurve curve, Eq (Point curve)) => EllipticCurveArith curve where
    -- | Add points on a curve
    pointAdd :: proxy curve -> Point curve -> Point curve -> Point curve

    -- | Negate a curve point
    pointNegate :: proxy curve -> Point curve -> Point curve

    -- | Scalar Multiplication on a curve
    pointSmul :: proxy curve -> Scalar curve -> Point curve -> Point curve

--   -- | Scalar Inverse
--   scalarInverse :: Scalar curve -> Scalar curve

-- | P256 Curve
--
-- also known as P256
data Curve_P256R1 = Curve_P256R1
    deriving (Show,Data)

instance EllipticCurve Curve_P256R1 where
    type Point Curve_P256R1 = P256.Point
    type Scalar Curve_P256R1 = P256.Scalar
    curveSizeBits _ = 256
    curveGenerateScalar _ = P256.scalarGenerate
    curveGenerateKeyPair _ = toKeyPair <$> P256.scalarGenerate
      where toKeyPair scalar = KeyPair (P256.toPoint scalar) scalar
    encodePoint _ p = mxy
      where
        mxy :: forall bs. ByteArray bs => bs
        mxy = B.concat [uncompressed, xy]
          where
            uncompressed, xy :: bs
            uncompressed = B.singleton 4
            xy = P256.pointToBinary p
    decodePoint _ mxy = case B.uncons mxy of
        Nothing -> CryptoFailed $ CryptoError_PointSizeInvalid
        Just (m,xy)
            -- uncompressed
            | m == 4 -> P256.pointFromBinary xy
            | otherwise -> CryptoFailed $ CryptoError_PointFormatInvalid

instance EllipticCurveArith Curve_P256R1 where
    pointAdd  _ a b = P256.pointAdd a b
    pointNegate _ p = P256.pointNegate p
    pointSmul _ s p = P256.pointMul s p

instance EllipticCurveDH Curve_P256R1 where
    ecdhRaw _ s p = SharedSecret $ P256.pointDh s p
    ecdh  prx s p = checkNonZeroDH (ecdhRaw prx s p)

data Curve_P384R1 = Curve_P384R1
    deriving (Show,Data)

instance EllipticCurve Curve_P384R1 where
    type Point Curve_P384R1 = Simple.Point Simple.SEC_p384r1
    type Scalar Curve_P384R1 = Simple.Scalar Simple.SEC_p384r1
    curveSizeBits _ = 384
    curveGenerateScalar _ = Simple.scalarGenerate
    curveGenerateKeyPair _ = toKeyPair <$> Simple.scalarGenerate
      where toKeyPair scalar = KeyPair (Simple.pointBaseMul scalar) scalar
    encodePoint _ point = encodeECPoint point
    decodePoint _ bs = decodeECPoint bs

instance EllipticCurveArith Curve_P384R1 where
    pointAdd _ a b = Simple.pointAdd a b
    pointNegate _ p = Simple.pointNegate p
    pointSmul _ s p = Simple.pointMul s p

instance EllipticCurveDH Curve_P384R1 where
    ecdh _ s p = encodeECShared prx (Simple.pointMul s p)
      where
        prx = Proxy :: Proxy Simple.SEC_p384r1

data Curve_P521R1 = Curve_P521R1
    deriving (Show,Data)

instance EllipticCurve Curve_P521R1 where
    type Point Curve_P521R1 = Simple.Point Simple.SEC_p521r1
    type Scalar Curve_P521R1 = Simple.Scalar Simple.SEC_p521r1
    curveSizeBits _ = 521
    curveGenerateScalar _ = Simple.scalarGenerate
    curveGenerateKeyPair _ = toKeyPair <$> Simple.scalarGenerate
      where toKeyPair scalar = KeyPair (Simple.pointBaseMul scalar) scalar
    encodePoint _ point = encodeECPoint point
    decodePoint _ bs = decodeECPoint bs

instance EllipticCurveArith Curve_P521R1 where
    pointAdd _ a b = Simple.pointAdd a b
    pointNegate _ p = Simple.pointNegate p
    pointSmul _ s p = Simple.pointMul s p

instance EllipticCurveDH Curve_P521R1 where
    ecdh _ s p = encodeECShared prx (Simple.pointMul s p)
      where
        prx = Proxy :: Proxy Simple.SEC_p521r1

data Curve_X25519 = Curve_X25519
    deriving (Show,Data)

instance EllipticCurve Curve_X25519 where
    type Point Curve_X25519 = X25519.PublicKey
    type Scalar Curve_X25519 = X25519.SecretKey
    curveSizeBits _ = 255
    curveGenerateScalar _ = X25519.generateSecretKey
    curveGenerateKeyPair _ = do
        s <- X25519.generateSecretKey
        return $ KeyPair (X25519.toPublic s) s
    encodePoint _ p = B.convert p
    decodePoint _ bs = X25519.publicKey bs

instance EllipticCurveDH Curve_X25519 where
    ecdhRaw _ s p = SharedSecret $ convert secret
      where secret = X25519.dh p s
    ecdh prx s p = checkNonZeroDH (ecdhRaw prx s p)

data Curve_X448 = Curve_X448
    deriving (Show,Data)

instance EllipticCurve Curve_X448 where
    type Point Curve_X448 = X448.PublicKey
    type Scalar Curve_X448 = X448.SecretKey
    curveSizeBits _ = 448
    curveGenerateScalar _ = X448.generateSecretKey
    curveGenerateKeyPair _ = do
        s <- X448.generateSecretKey
        return $ KeyPair (X448.toPublic s) s
    encodePoint _ p = B.convert p
    decodePoint _ bs = X448.publicKey bs

instance EllipticCurveDH Curve_X448 where
    ecdhRaw _ s p = SharedSecret $ convert secret
      where secret = X448.dh p s
    ecdh prx s p = checkNonZeroDH (ecdhRaw prx s p)

data Curve_Edwards25519 = Curve_Edwards25519
    deriving (Show,Data)

instance EllipticCurve Curve_Edwards25519 where
    type Point Curve_Edwards25519 = Edwards25519.Point
    type Scalar Curve_Edwards25519 = Edwards25519.Scalar
    curveSizeBits _ = 255
    curveGenerateScalar _ = Edwards25519.scalarGenerate
    curveGenerateKeyPair _ = toKeyPair <$> Edwards25519.scalarGenerate
      where toKeyPair scalar = KeyPair (Edwards25519.toPoint scalar) scalar
    encodePoint _ point = Edwards25519.pointEncode point
    decodePoint _ bs = Edwards25519.pointDecode bs

instance EllipticCurveArith Curve_Edwards25519 where
    pointAdd _ a b = Edwards25519.pointAdd a b
    pointNegate _ p = Edwards25519.pointNegate p
    pointSmul _ s p = Edwards25519.pointMul s p

checkNonZeroDH :: SharedSecret -> CryptoFailable SharedSecret
checkNonZeroDH s@(SharedSecret b)
    | B.constAllZero b = CryptoFailed CryptoError_ScalarMultiplicationInvalid
    | otherwise        = CryptoPassed s

encodeECShared :: Simple.Curve curve => Proxy curve -> Simple.Point curve -> CryptoFailable SharedSecret
encodeECShared _   Simple.PointO      = CryptoFailed CryptoError_ScalarMultiplicationInvalid
encodeECShared prx (Simple.Point x _) = CryptoPassed . SharedSecret $ i2ospOf_ (Simple.curveSizeBytes prx) x

encodeECPoint :: forall curve bs . (Simple.Curve curve, ByteArray bs) => Simple.Point curve -> bs
encodeECPoint Simple.PointO      = error "encodeECPoint: cannot serialize point at infinity"
encodeECPoint (Simple.Point x y) = B.concat [uncompressed,xb,yb]
  where
    size = Simple.curveSizeBytes (Proxy :: Proxy curve)
    uncompressed, xb, yb :: bs
    uncompressed = B.singleton 4
    xb = i2ospOf_ size x
    yb = i2ospOf_ size y

decodeECPoint :: (Simple.Curve curve, ByteArray bs) => bs -> CryptoFailable (Simple.Point curve)
decodeECPoint mxy = case B.uncons mxy of
    Nothing     -> CryptoFailed $ CryptoError_PointSizeInvalid
    Just (m,xy)
        -- uncompressed
        | m == 4 ->
            let siz = B.length xy `div` 2
                (xb,yb) = B.splitAt siz xy
                x = os2ip xb
                y = os2ip yb
             in Simple.pointFromIntegers (x,y)
        | otherwise -> CryptoFailed $ CryptoError_PointFormatInvalid

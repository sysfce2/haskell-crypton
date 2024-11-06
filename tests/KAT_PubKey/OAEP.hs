{-# LANGUAGE OverloadedStrings #-}

module KAT_PubKey.OAEP (oaepTests) where

import Crypto.Hash
import Crypto.PubKey.RSA
import qualified Crypto.PubKey.RSA.OAEP as OAEP

import Imports

rsaKeyInt =
    PrivateKey
        { private_pub =
            PublicKey
                { public_n =
                    0xbbf82f090682ce9c2338ac2b9da871f7368d07eed41043a440d6b6f07454f51fb8dfbaaf035c02ab61ea48ceeb6fcd4876ed520d60e1ec4619719d8a5b8b807fafb8e0a3dfc737723ee6b4b7d93a2584ee6a649d060953748834b2454598394ee0aab12d7b61a51f527a9a41f6c1687fe2537298ca2a8f5946f8e5fd091dbdcb
                , public_e = 0x11
                , public_size = 128
                }
        , private_d =
            0xa5dafc5341faf289c4b988db30c1cdf83f31251e0668b42784813801579641b29410b3c7998d6bc465745e5c392669d6870da2c082a939e37fdcb82ec93edac97ff3ad5950accfbc111c76f1a9529444e56aaf68c56c092cd38dc3bef5d20a939926ed4f74a13eddfbe1a1cecc4894af9428c2b7b8883fe4463a4bc85b1cb3c1
        , private_p =
            0xeecfae81b1b9b3c908810b10a1b5600199eb9f44aef4fda493b81a9e3d84f632124ef0236e5d1e3b7e28fae7aa040a2d5b252176459d1f397541ba2a58fb6599
        , private_q =
            0xc97fb1f027f453f6341233eaaad1d9353f6c42d08866b1d05a0f2035028b9d869840b41666b42e92ea0da3b43204b5cfce3352524d0416a5a441e700af461503
        , private_dP =
            0x54494ca63eba0337e4e24023fcd69a5aeb07dddc0183a4d0ac9b54b051f2b13ed9490975eab77414ff59c1f7692e9a2e202b38fc910a474174adc93c1f67c981
        , private_dQ =
            0x471e0290ff0af0750351b7f878864ca961adbd3a8a7e991c5c0556a94c3146a7f9803f8f6f8ae342e931fd8ae47a220d1b99a495849807fe39f9245a9836da3d
        , private_qinv =
            0xb06c4fdabb6301198d265bdbae9423b380f271f73453885093077fcd39e2119fc98632154f5883b167a967bf402b4e9e2e0f9656e698ea3666edfb25798039f7
        }

rsaKey1 =
    PrivateKey
        { private_pub =
            PublicKey
                { public_n =
                    0xa8b3b284af8eb50b387034a860f146c4919f318763cd6c5598c8ae4811a1e0abc4c7e0b082d693a5e7fced675cf4668512772c0cbc64a742c6c630f533c8cc72f62ae833c40bf25842e984bb78bdbf97c0107d55bdb662f5c4e0fab9845cb5148ef7392dd3aaff93ae1e6b667bb3d4247616d4f5ba10d4cfd226de88d39f16fb
                , public_e = 0x010001
                , public_size = 128
                }
        , private_d =
            0x53339cfdb79fc8466a655c7316aca85c55fd8f6dd898fdaf119517ef4f52e8fd8e258df93fee180fa0e4ab29693cd83b152a553d4ac4d1812b8b9fa5af0e7f55fe7304df41570926f3311f15c4d65a732c483116ee3d3d2d0af3549ad9bf7cbfb78ad884f84d5beb04724dc7369b31def37d0cf539e9cfcdd3de653729ead5d1
        , private_p =
            0xd32737e7267ffe1341b2d5c0d150a81b586fb3132bed2f8d5262864a9cb9f30af38be448598d413a172efb802c21acf1c11c520c2f26a471dcad212eac7ca39d
        , private_q =
            0xcc8853d1d54da630fac004f471f281c7b8982d8224a490edbeb33d3e3d5cc93c4765703d1dd791642f1f116a0dd852be2419b2af72bfe9a030e860b0288b5d77
        , private_dP =
            0x0e12bf1718e9cef5599ba1c3882fe8046a90874eefce8f2ccc20e4f2741fb0a33a3848aec9c9305fbecbd2d76819967d4671acc6431e4037968db37878e695c1
        , private_dQ =
            0x95297b0f95a2fa67d00707d609dfd4fc05c89dafc2ef6d6ea55bec771ea333734d9251e79082ecda866efef13c459e1a631386b7e354c899f5f112ca85d71583
        , private_qinv =
            0x4f456c502493bdc0ed2ab756a3a6ed4d67352a697d4216e93212b127a63d5411ce6fa98d5dbefd73263e3728142743818166ed7dd63687dd2a8ca1d2f4fbd8e1
        }

data VectorOAEP = VectorOAEP
    { seed :: ByteString
    , message :: ByteString
    , cipherText :: ByteString
    }
vectorInt =
    VectorOAEP
        { message = "\xd4\x36\xe9\x95\x69\xfd\x32\xa7\xc8\xa0\x5b\xbc\x90\xd3\x2c\x49"
        , seed =
            "\xaa\xfd\x12\xf6\x59\xca\xe6\x34\x89\xb4\x79\xe5\x07\x6d\xde\xc2\xf0\x6c\xb5\x8f"
        , cipherText =
            "\x12\x53\xe0\x4d\xc0\xa5\x39\x7b\xb4\x4a\x7a\xb8\x7e\x9b\xf2\xa0\x39\xa3\x3d\x1e\x99\x6f\xc8\x2a\x94\xcc\xd3\x00\x74\xc9\x5d\xf7\x63\x72\x20\x17\x06\x9e\x52\x68\xda\x5d\x1c\x0b\x4f\x87\x2c\xf6\x53\xc1\x1d\xf8\x23\x14\xa6\x79\x68\xdf\xea\xe2\x8d\xef\x04\xbb\x6d\x84\xb1\xc3\x1d\x65\x4a\x19\x70\xe5\x78\x3b\xd6\xeb\x96\xa0\x24\xc2\xca\x2f\x4a\x90\xfe\x9f\x2e\xf5\xc9\xc1\x40\xe5\xbb\x48\xda\x95\x36\xad\x87\x00\xc8\x4f\xc9\x13\x0a\xde\xa7\x4e\x55\x8d\x51\xa7\x4d\xdf\x85\xd8\xb5\x0d\xe9\x68\x38\xd6\x06\x3e\x09\x55"
        }

vectorsKey1 =
    [ VectorOAEP -- 1.1
        { message =
            "\x66\x28\x19\x4e\x12\x07\x3d\xb0\x3b\xa9\x4c\xda\x9e\xf9\x53\x23\x97\xd5\x0d\xba\x79\xb9\x87\x00\x4a\xfe\xfe\x34"
        , seed =
            "\x18\xb7\x76\xea\x21\x06\x9d\x69\x77\x6a\x33\xe9\x6b\xad\x48\xe1\xdd\xa0\xa5\xef"
        , cipherText =
            "\x35\x4f\xe6\x7b\x4a\x12\x6d\x5d\x35\xfe\x36\xc7\x77\x79\x1a\x3f\x7b\xa1\x3d\xef\x48\x4e\x2d\x39\x08\xaf\xf7\x22\xfa\xd4\x68\xfb\x21\x69\x6d\xe9\x5d\x0b\xe9\x11\xc2\xd3\x17\x4f\x8a\xfc\xc2\x01\x03\x5f\x7b\x6d\x8e\x69\x40\x2d\xe5\x45\x16\x18\xc2\x1a\x53\x5f\xa9\xd7\xbf\xc5\xb8\xdd\x9f\xc2\x43\xf8\xcf\x92\x7d\xb3\x13\x22\xd6\xe8\x81\xea\xa9\x1a\x99\x61\x70\xe6\x57\xa0\x5a\x26\x64\x26\xd9\x8c\x88\x00\x3f\x84\x77\xc1\x22\x70\x94\xa0\xd9\xfa\x1e\x8c\x40\x24\x30\x9c\xe1\xec\xcc\xb5\x21\x00\x35\xd4\x7a\xc7\x2e\x8a"
        }
    , VectorOAEP -- 1.2
        { message =
            "\x75\x0c\x40\x47\xf5\x47\xe8\xe4\x14\x11\x85\x65\x23\x29\x8a\xc9\xba\xe2\x45\xef\xaf\x13\x97\xfb\xe5\x6f\x9d\xd5"
        , seed =
            "\x0c\xc7\x42\xce\x4a\x9b\x7f\x32\xf9\x51\xbc\xb2\x51\xef\xd9\x25\xfe\x4f\xe3\x5f"
        , cipherText =
            "\x64\x0d\xb1\xac\xc5\x8e\x05\x68\xfe\x54\x07\xe5\xf9\xb7\x01\xdf\xf8\xc3\xc9\x1e\x71\x6c\x53\x6f\xc7\xfc\xec\x6c\xb5\xb7\x1c\x11\x65\x98\x8d\x4a\x27\x9e\x15\x77\xd7\x30\xfc\x7a\x29\x93\x2e\x3f\x00\xc8\x15\x15\x23\x6d\x8d\x8e\x31\x01\x7a\x7a\x09\xdf\x43\x52\xd9\x04\xcd\xeb\x79\xaa\x58\x3a\xdc\xc3\x1e\xa6\x98\xa4\xc0\x52\x83\xda\xba\x90\x89\xbe\x54\x91\xf6\x7c\x1a\x4e\xe4\x8d\xc7\x4b\xbb\xe6\x64\x3a\xef\x84\x66\x79\xb4\xcb\x39\x5a\x35\x2d\x5e\xd1\x15\x91\x2d\xf6\x96\xff\xe0\x70\x29\x32\x94\x6d\x71\x49\x2b\x44"
        }
    , VectorOAEP -- 1.3
        { message =
            "\xd9\x4a\xe0\x83\x2e\x64\x45\xce\x42\x33\x1c\xb0\x6d\x53\x1a\x82\xb1\xdb\x4b\xaa\xd3\x0f\x74\x6d\xc9\x16\xdf\x24\xd4\xe3\xc2\x45\x1f\xff\x59\xa6\x42\x3e\xb0\xe1\xd0\x2d\x4f\xe6\x46\xcf\x69\x9d\xfd\x81\x8c\x6e\x97\xb0\x51"
        , seed =
            "\x25\x14\xdf\x46\x95\x75\x5a\x67\xb2\x88\xea\xf4\x90\x5c\x36\xee\xc6\x6f\xd2\xfd"
        , cipherText =
            "\x42\x37\x36\xed\x03\x5f\x60\x26\xaf\x27\x6c\x35\xc0\xb3\x74\x1b\x36\x5e\x5f\x76\xca\x09\x1b\x4e\x8c\x29\xe2\xf0\xbe\xfe\xe6\x03\x59\x5a\xa8\x32\x2d\x60\x2d\x2e\x62\x5e\x95\xeb\x81\xb2\xf1\xc9\x72\x4e\x82\x2e\xca\x76\xdb\x86\x18\xcf\x09\xc5\x34\x35\x03\xa4\x36\x08\x35\xb5\x90\x3b\xc6\x37\xe3\x87\x9f\xb0\x5e\x0e\xf3\x26\x85\xd5\xae\xc5\x06\x7c\xd7\xcc\x96\xfe\x4b\x26\x70\xb6\xea\xc3\x06\x6b\x1f\xcf\x56\x86\xb6\x85\x89\xaa\xfb\x7d\x62\x9b\x02\xd8\xf8\x62\x5c\xa3\x83\x36\x24\xd4\x80\x0f\xb0\x81\xb1\xcf\x94\xeb"
        }
    , VectorOAEP
        { message =
            "\x52\xe6\x50\xd9\x8e\x7f\x2a\x04\x8b\x4f\x86\x85\x21\x53\xb9\x7e\x01\xdd\x31\x6f\x34\x6a\x19\xf6\x7a\x85"
        , seed =
            "\xc4\x43\x5a\x3e\x1a\x18\xa6\x8b\x68\x20\x43\x62\x90\xa3\x7c\xef\xb8\x5d\xb3\xfb"
        , cipherText =
            "\x45\xea\xd4\xca\x55\x1e\x66\x2c\x98\x00\xf1\xac\xa8\x28\x3b\x05\x25\xe6\xab\xae\x30\xbe\x4b\x4a\xba\x76\x2f\xa4\x0f\xd3\xd3\x8e\x22\xab\xef\xc6\x97\x94\xf6\xeb\xbb\xc0\x5d\xdb\xb1\x12\x16\x24\x7d\x2f\x41\x2f\xd0\xfb\xa8\x7c\x6e\x3a\xcd\x88\x88\x13\x64\x6f\xd0\xe4\x8e\x78\x52\x04\xf9\xc3\xf7\x3d\x6d\x82\x39\x56\x27\x22\xdd\xdd\x87\x71\xfe\xc4\x8b\x83\xa3\x1e\xe6\xf5\x92\xc4\xcf\xd4\xbc\x88\x17\x4f\x3b\x13\xa1\x12\xaa\xe3\xb9\xf7\xb8\x0e\x0f\xc6\xf7\x25\x5b\xa8\x80\xdc\x7d\x80\x21\xe2\x2a\xd6\xa8\x5f\x07\x55"
        }
    , VectorOAEP
        { message =
            "\x8d\xa8\x9f\xd9\xe5\xf9\x74\xa2\x9f\xef\xfb\x46\x2b\x49\x18\x0f\x6c\xf9\xe8\x02"
        , seed =
            "\xb3\x18\xc4\x2d\xf3\xbe\x0f\x83\xfe\xa8\x23\xf5\xa7\xb4\x7e\xd5\xe4\x25\xa3\xb5"
        , cipherText =
            "\x36\xf6\xe3\x4d\x94\xa8\xd3\x4d\xaa\xcb\xa3\x3a\x21\x39\xd0\x0a\xd8\x5a\x93\x45\xa8\x60\x51\xe7\x30\x71\x62\x00\x56\xb9\x20\xe2\x19\x00\x58\x55\xa2\x13\xa0\xf2\x38\x97\xcd\xcd\x73\x1b\x45\x25\x7c\x77\x7f\xe9\x08\x20\x2b\xef\xdd\x0b\x58\x38\x6b\x12\x44\xea\x0c\xf5\x39\xa0\x5d\x5d\x10\x32\x9d\xa4\x4e\x13\x03\x0f\xd7\x60\xdc\xd6\x44\xcf\xef\x20\x94\xd1\x91\x0d\x3f\x43\x3e\x1c\x7c\x6d\xd1\x8b\xc1\xf2\xdf\x7f\x64\x3d\x66\x2f\xb9\xdd\x37\xea\xd9\x05\x91\x90\xf4\xfa\x66\xca\x39\xe8\x69\xc4\xeb\x44\x9c\xbd\xc4\x39"
        }
    , VectorOAEP -- 1.6
        { message = "\x26\x52\x10\x50\x84\x42\x71"
        , seed =
            "\xe4\xec\x09\x82\xc2\x33\x6f\x3a\x67\x7f\x6a\x35\x61\x74\xeb\x0c\xe8\x87\xab\xc2"
        , cipherText =
            "\x42\xce\xe2\x61\x7b\x1e\xce\xa4\xdb\x3f\x48\x29\x38\x6f\xbd\x61\xda\xfb\xf0\x38\xe1\x80\xd8\x37\xc9\x63\x66\xdf\x24\xc0\x97\xb4\xab\x0f\xac\x6b\xdf\x59\x0d\x82\x1c\x9f\x10\x64\x2e\x68\x1a\xd0\x5b\x8d\x78\xb3\x78\xc0\xf4\x6c\xe2\xfa\xd6\x3f\x74\xe0\xad\x3d\xf0\x6b\x07\x5d\x7e\xb5\xf5\x63\x6f\x8d\x40\x3b\x90\x59\xca\x76\x1b\x5c\x62\xbb\x52\xaa\x45\x00\x2e\xa7\x0b\xaa\xce\x08\xde\xd2\x43\xb9\xd8\xcb\xd6\x2a\x68\xad\xe2\x65\x83\x2b\x56\x56\x4e\x43\xa6\xfa\x42\xed\x19\x9a\x09\x97\x69\x74\x2d\xf1\x53\x9e\x82\x55"
        }
    ]

doEncryptionTest key i vec = testCase (show i) (Right (cipherText vec) @=? actual)
  where
    actual =
        OAEP.encryptWithSeed (seed vec) (OAEP.defaultOAEPParams SHA1) key (message vec)

doDecryptionTest key i vec = testCase (show i) (Right (message vec) @=? actual)
  where
    actual = OAEP.decrypt Nothing (OAEP.defaultOAEPParams SHA1) key (cipherText vec)

oaepTests =
    testGroup
        "RSA-OAEP"
        [ testGroup
            "internal"
            [ doEncryptionTest (private_pub rsaKeyInt) (0 :: Int) vectorInt
            , doDecryptionTest rsaKeyInt (0 :: Int) vectorInt
            ]
        , testGroup "encryption key 1024 bits" $
            zipWith (doEncryptionTest $ private_pub rsaKey1) [katZero ..] vectorsKey1
        , testGroup "decryption key 1024 bits" $
            zipWith (doDecryptionTest rsaKey1) [katZero ..] vectorsKey1
        ]

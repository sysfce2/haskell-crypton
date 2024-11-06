{-# LANGUAGE OverloadedStrings #-}

module XSalsa (tests) where

import qualified Crypto.Cipher.XSalsa as XSalsa
import qualified Data.ByteString as B

import Imports

type Vector = (Int, B.ByteString, B.ByteString, B.ByteString, B.ByteString)

-- Test vectors generated by naclcrypto library (https://nacl.cr.yp.to)
vectors :: [Vector]
vectors =
    [
        ( 20
        , "\xA6\xA7\x25\x1C\x1E\x72\x91\x6D\x11\xC2\xCB\x21\x4D\x3C\x25\x25\x39\x12\x1D\x8E\x23\x4E\x65\x2D\x65\x1F\xA4\xC8\xCF\xF8\x80\x30"
        , "\x9E\x64\x5A\x74\xE9\xE0\xA6\x0D\x82\x43\xAC\xD9\x17\x7A\xB5\x1A\x1B\xEB\x8D\x5A\x2F\x5D\x70\x0C"
        , "\x09\x3C\x5E\x55\x85\x57\x96\x25\x33\x7B\xD3\xAB\x61\x9D\x61\x57\x60\xD8\xC5\xB2\x24\xA8\x5B\x1D\x0E\xFE\x0E\xB8\xA7\xEE\x16\x3A\xBB\x03\x76\x52\x9F\xCC\x09\xBA\xB5\x06\xC6\x18\xE1\x3C\xE7\x77\xD8\x2C\x3A\xE9\xD1\xA6\xF9\x72\xD4\x16\x02\x87\xCB\xFE\x60\xBF\x21\x30\xFC\x0A\x6F\xF6\x04\x9D\x0A\x5C\x8A\x82\xF4\x29\x23\x1F\x00\x80\x82\xE8\x45\xD7\xE1\x89\xD3\x7F\x9E\xD2\xB4\x64\xE6\xB9\x19\xE6\x52\x3A\x8C\x12\x10\xBD\x52\xA0\x2A\x4C\x3F\xE4\x06\xD3\x08\x5F\x50\x68\xD1\x90\x9E\xEE\xCA\x63\x69\xAB\xC9\x81\xA4\x2E\x87\xFE\x66\x55\x83\xF0\xAB\x85\xAE\x71\xF6\xF8\x4F\x52\x8E\x6B\x39\x7A\xF8\x6F\x69\x17\xD9\x75\x4B\x73\x20\xDB\xDC\x2F\xEA\x81\x49\x6F\x27\x32\xF5\x32\xAC\x78\xC4\xE9\xC6\xCF\xB1\x8F\x8E\x9B\xDF\x74\x62\x2E\xB1\x26\x14\x14\x16\x77\x69\x71\xA8\x4F\x94\xD1\x56\xBE\xAF\x67\xAE\xCB\xF2\xAD\x41\x2E\x76\xE6\x6E\x8F\xAD\x76\x33\xF5\xB6\xD7\xF3\xD6\x4B\x5C\x6C\x69\xCE\x29\x00\x3C\x60\x24\x46\x5A\xE3\xB8\x9B\xE7\x8E\x91\x5D\x88\xB4\xB5\x62\x1D"
        , "\xB2\xAF\x68\x8E\x7D\x8F\xC4\xB5\x08\xC0\x5C\xC3\x9D\xD5\x83\xD6\x71\x43\x22\xC6\x4D\x7F\x3E\x63\x14\x7A\xED\xE2\xD9\x53\x49\x34\xB0\x4F\xF6\xF3\x37\xB0\x31\x81\x5C\xD0\x94\xBD\xBC\x6D\x7A\x92\x07\x7D\xCE\x70\x94\x12\x28\x68\x22\xEF\x07\x37\xEE\x47\xF6\xB7\xFF\xA2\x2F\x9D\x53\xF1\x1D\xD2\xB0\xA3\xBB\x9F\xC0\x1D\x9A\x88\xF9\xD5\x3C\x26\xE9\x36\x5C\x2C\x3C\x06\x3B\xC4\x84\x0B\xFC\x81\x2E\x4B\x80\x46\x3E\x69\xD1\x79\x53\x0B\x25\xC1\x58\xF5\x43\x19\x1C\xFF\x99\x31\x06\x51\x1A\xA0\x36\x04\x3B\xBC\x75\x86\x6A\xB7\xE3\x4A\xFC\x57\xE2\xCC\xE4\x93\x4A\x5F\xAA\xE6\xEA\xBE\x4F\x22\x17\x70\x18\x3D\xD0\x60\x46\x78\x27\xC2\x7A\x35\x41\x59\xA0\x81\x27\x5A\x29\x1F\x69\xD9\x46\xD6\xFE\x28\xED\x0B\x9C\xE0\x82\x06\xCF\x48\x49\x25\xA5\x1B\x94\x98\xDB\xDE\x17\x8D\xDD\x3A\xE9\x1A\x85\x81\xB9\x16\x82\xD8\x60\xF8\x40\x78\x2F\x6E\xEA\x49\xDB\xB9\xBD\x72\x15\x01\xD2\xC6\x71\x22\xDE\xA3\xB7\x28\x38\x48\xC5\xF1\x3E\x0C\x0D\xE8\x76\xBD\x22\x7A\x85\x6E\x4D\xE5\x93\xA3"
        )
    ,
        ( 20
        , "\x9E\x1D\xA2\x39\xD1\x55\xF5\x2A\xD3\x7F\x75\xC7\x36\x8A\x53\x66\x68\xB0\x51\x95\x29\x23\xAD\x44\xF5\x7E\x75\xAB\x58\x8E\x47\x5A"
        , "\xAF\x06\xF1\x78\x59\xDF\xFA\x79\x98\x91\xC4\x28\x8F\x66\x35\xB5\xC5\xA4\x5E\xEE\x90\x17\xFD\x72"
        , "\xFE\xAC\x9D\x54\xFC\x8C\x11\x5A\xE2\x47\xD9\xA7\xE9\x19\xDD\x76\xCF\xCB\xC7\x2D\x32\xCA\xE4\x94\x48\x60\x81\x7C\xBD\xFB\x8C\x04\xE6\xB1\xDF\x76\xA1\x65\x17\xCD\x33\xCC\xF1\xAC\xDA\x92\x06\x38\x9E\x9E\x31\x8F\x59\x66\xC0\x93\xCF\xB3\xEC\x2D\x9E\xE2\xDE\x85\x64\x37\xED\x58\x1F\x55\x2F\x26\xAC\x29\x07\x60\x9D\xF8\xC6\x13\xB9\xE3\x3D\x44\xBF\xC2\x1F\xF7\x91\x53\xE9\xEF\x81\xA9\xD6\x6C\xC3\x17\x85\x7F\x75\x2C\xC1\x75\xFD\x88\x91\xFE\xFE\xBB\x7D\x04\x1E\x65\x17\xC3\x16\x2D\x19\x7E\x21\x12\x83\x7D\x3B\xC4\x10\x43\x12\xAD\x35\xB7\x5E\xA6\x86\xE7\xC7\x0D\x4E\xC0\x47\x46\xB5\x2F\xF0\x9C\x42\x14\x51\x45\x9F\xB5\x9F"
        , "\x2C\x26\x1A\x2F\x4E\x61\xA6\x2E\x1B\x27\x68\x99\x16\xBF\x03\x45\x3F\xCB\xC9\x7B\xB2\xAF\x6F\x32\x93\x91\xEF\x06\x3B\x5A\x21\x9B\xF9\x84\xD0\x7D\x70\xF6\x02\xD8\x5F\x6D\xB6\x14\x74\xE9\xD9\xF5\xA2\xDE\xEC\xB4\xFC\xD9\x01\x84\xD1\x6F\x3B\x5B\x5E\x16\x8E\xE0\x3E\xA8\xC9\x3F\x39\x33\xA2\x2B\xC3\xD1\xA5\xAE\x8C\x2D\x8B\x02\x75\x7C\x87\xC0\x73\x40\x90\x52\xA2\xA8\xA4\x1E\x7F\x48\x7E\x04\x1F\x9A\x49\xA0\x99\x7B\x54\x0E\x18\x62\x1C\xAD\x3A\x24\xF0\xA5\x6D\x9B\x19\x22\x79\x29\x05\x7A\xB3\xBA\x95\x0F\x62\x74\xB1\x21\xF1\x93\xE3\x2E\x06\xE5\x38\x87\x81\xA1\xCB\x57\x31\x7C\x0B\xA6\x30\x5E\x91\x09\x61\xD0\x10\x02\xF0"
        )
    ,
        ( 20
        , "\xD5\xC7\xF6\x79\x7B\x7E\x7E\x9C\x1D\x7F\xD2\x61\x0B\x2A\xBF\x2B\xC5\xA7\x88\x5F\xB3\xFF\x78\x09\x2F\xB3\xAB\xE8\x98\x6D\x35\xE2"
        , "\x74\x4E\x17\x31\x2B\x27\x96\x9D\x82\x64\x44\x64\x0E\x9C\x4A\x37\x8A\xE3\x34\xF1\x85\x36\x9C\x95"
        , "\x77\x58\x29\x8C\x62\x8E\xB3\xA4\xB6\x96\x3C\x54\x45\xEF\x66\x97\x12\x22\xBE\x5D\x1A\x4A\xD8\x39\x71\x5D\x11\x88\x07\x17\x39\xB7\x7C\xC6\xE0\x5D\x54\x10\xF9\x63\xA6\x41\x67\x62\x97\x57"
        , "\x27\xB8\xCF\xE8\x14\x16\xA7\x63\x01\xFD\x1E\xEC\x6A\x4D\x99\x67\x50\x69\xB2\xDA\x27\x76\xC3\x60\xDB\x1B\xDF\xEA\x7C\x0A\xA6\x13\x91\x3E\x10\xF7\xA6\x0F\xEC\x04\xD1\x1E\x65\xF2\xD6\x4E"
        )
    ,
        ( 20
        , "\x73\x7D\x78\x11\xCE\x96\x47\x2E\xFE\xD1\x22\x58\xB7\x81\x22\xF1\x1D\xEA\xEC\x87\x59\xCC\xBD\x71\xEA\xC6\xBB\xEF\xA6\x27\x78\x5C"
        , "\x6F\xB2\xEE\x3D\xDA\x6D\xBD\x12\xF1\x27\x4F\x12\x67\x01\xEC\x75\xC3\x5C\x86\x60\x7A\xDB\x3E\xDD"
        , "\x50\x13\x25\xFB\x26\x45\x26\x48\x64\xDF\x11\xFA\xA1\x7B\xBD\x58\x31\x2B\x77\xCA\xD3\xD9\x4A\xC8\xFB\x85\x42\xF0\xEB\x65\x3A\xD7\x3D\x7F\xCE\x93\x2B\xB8\x74\xCB\x89\xAC\x39\xFC\x47\xF8\x26\x7C\xF0\xF0\xC2\x09\xF2\x04\xB2\xD8\x57\x8A\x3B\xDF\x46\x1C\xB6\xA2\x71\xA4\x68\xBE\xBA\xCC\xD9\x68\x50\x14\xCC\xBC\x9A\x73\x61\x8C\x6A\x5E\x77\x8A\x21\xCC\x84\x16\xC6\x0A\xD2\x4D\xDC\x41\x7A\x13\x0D\x53\xED\xA6\xDF\xBF\xE4\x7D\x09\x17\x0A\x7B\xE1\xA7\x08\xB7\xB5\xF3\xAD\x46\x43\x10\xBE\x36\xD9\xA2\xA9\x5D\xC3\x9E\x83\xD3\x86\x67\xE8\x42\xEB\x64\x11\xE8\xA2\x37\x12\x29\x7B\x16\x5F\x69\x0C\x2D\x7C\xA1\xB1\x34\x6E\x3C\x1F\xCC\xF5\xCA\xFD\x4F\x8B\xE0"
        , "\x67\x24\xC3\x72\xD2\xE9\x07\x4D\xA5\xE2\x7A\x6C\x54\xB2\xD7\x03\xDC\x1D\x4C\x9B\x1F\x8D\x90\xF0\x0C\x12\x2E\x69\x2A\xCE\x77\x00\xEA\xDC\xA9\x42\x54\x45\x07\xF1\x37\x5B\x65\x81\xD5\xA8\xFB\x39\x98\x1C\x1C\x0E\x6E\x1F\xF2\x14\x0B\x08\x2E\x9E\xC0\x16\xFC\xE1\x41\xD5\x19\x96\x47\xD4\x3B\x0B\x68\xBF\xD0\xFE\xA5\xE0\x0F\x46\x89\x62\xC7\x38\x4D\xD6\x12\x9A\xEA\x6A\x3F\xDF\xE7\x5A\xBB\x21\x0E\xD5\x60\x7C\xEF\x8F\xA0\xE1\x52\x83\x3D\x5A\xC3\x7D\x52\xE5\x57\xB9\x10\x98\xA3\x22\xE7\x6A\x45\xBB\xBC\xF4\x89\x9E\x79\x06\x18\xAA\x3F\x4C\x2E\x5E\x0F\xC3\xDE\x93\x26\x9A\x57\x7D\x77\xA5\x50\x2E\x8E\xA0\x2F\x71\x7B\x1D\xD2\xDF\x1E\xC6\x9D\x8B\x61\xCA"
        )
    ,
        ( 20
        , "\x76\x01\x58\xDA\x09\xF8\x9B\xBA\xB2\xC9\x9E\x69\x97\xF9\x52\x3A\x95\xFC\xEF\x10\x23\x9B\xCC\xA2\x57\x3B\x71\x05\xF6\x89\x8D\x34"
        , "\x43\x63\x6B\x2C\xC3\x46\xFC\x8B\x7C\x85\xA1\x9B\xF5\x07\xBD\xC3\xDA\xFE\x95\x3B\x88\xC6\x9D\xBA"
        , "\xD3\x0A\x6D\x42\xDF\xF4\x9F\x0E\xD0\x39\xA3\x06\xBA\xE9\xDE\xC8\xD9\xE8\x83\x66\xCC\x19\xE8\xC3\x64\x2F\xD5\x8F\xA0\x79\x4E\xBF\x80\x29\xD9\x49\x73\x03\x39\xB0\x82\x3A\x51\xF0\xF4\x9F\x0D\x2C\x71\xF1\x05\x1C\x1E\x0E\x2C\x86\x94\x1F\x17\x27\x89\xCD\xB1\xB0\x10\x74\x13\xE7\x0F\x98\x2F\xF9\x76\x18\x77\xBB\x52\x6E\xF1\xC3\xEB\x11\x06\xA9\x48\xD6\x0E\xF2\x1B\xD3\x5D\x32\xCF\xD6\x4F\x89\xB7\x9E\xD6\x3E\xCC\x5C\xCA\x56\x24\x6A\xF7\x36\x76\x6F\x28\x5D\x8E\x6B\x0D\xA9\xCB\x1C\xD2\x10\x20\x22\x3F\xFA\xCC\x5A\x32"
        , "\xC8\x15\xB6\xB7\x9B\x64\xF9\x36\x9A\xEC\x8D\xCE\x8C\x75\x3D\xF8\xA5\x0F\x2B\xC9\x7C\x70\xCE\x2F\x01\x4D\xB3\x3A\x65\xAC\x58\x16\xBA\xC9\xE3\x0A\xC0\x8B\xDD\xED\x30\x8C\x65\xCB\x87\xE2\x8E\x2E\x71\xB6\x77\xDC\x25\xC5\xA6\x49\x9C\x15\x53\x55\x5D\xAF\x1F\x55\x27\x0A\x56\x95\x9D\xFF\xA0\xC6\x6F\x24\xE0\xAF\x00\x95\x1E\xC4\xBB\x59\xCC\xC3\xA6\xC5\xF5\x2E\x09\x81\x64\x7E\x53\xE4\x39\x31\x3A\x52\xC4\x0F\xA7\x00\x4C\x85\x5B\x6E\x6E\xB2\x5B\x21\x2A\x13\x8E\x84\x3A\x9B\xA4\x6E\xDB\x2A\x03\x9E\xE8\x2A\x26\x3A\xBE"
        )
    ,
        ( 20
        , "\x27\xBA\x7E\x81\xE7\xED\xD4\xE7\x1B\xE5\x3C\x07\xCE\x8E\x63\x31\x38\xF2\x87\xE1\x55\xC7\xFA\x9E\x84\xC4\xAD\x80\x4B\x7F\xA1\xB9"
        , "\xEA\x05\xF4\xEB\xCD\x2F\xB6\xB0\x00\xDA\x06\x12\x86\x1B\xA5\x4F\xF5\xC1\x76\xFB\x60\x13\x91\xAA"
        , "\xE0\x9F\xF5\xD2\xCB\x05\x0D\x69\xB2\xD4\x24\x94\xBD\xE5\x82\x52\x38\xC7\x56\xD6\x99\x1D\x99\xD7\xA2\x0D\x1E\xF0\xB8\x3C\x37\x1C\x89\x87\x26\x90\xB2\xFC\x11\xD5\x36\x9F\x4F\xC4\x97\x1B\x6D\x3D\x6C\x07\x8A\xEF\x9B\x0F\x05\xC0\xE6\x1A\xB8\x9C\x02\x51\x68\x05\x4D\xEF\xEB\x03\xFE\xF6\x33\x85\x87\x00\xC5\x8B\x12\x62\xCE\x01\x13\x00\x01\x26\x73\xE8\x93\xE4\x49\x01\xDC\x18\xEE\xE3\x10\x56\x99\xC4\x4C\x80\x58\x97\xBD\xAF\x77\x6A\xF1\x83\x31\x62\xA2\x1A"
        , "\xA2\x3E\x7E\xF9\x3C\x5D\x06\x67\xC9\x6D\x9E\x40\x4D\xCB\xE6\xBE\x62\x02\x6F\xA9\x8F\x7A\x3F\xF9\xBA\x5D\x45\x86\x43\xA1\x6A\x1C\xEF\x72\x72\xDC\x60\x97\xA9\xB5\x2F\x35\x98\x35\x57\xC7\x7A\x11\xB3\x14\xB4\xF7\xD5\xDC\x2C\xCA\x15\xEE\x47\x61\x6F\x86\x18\x73\xCB\xFE\xD1\xD3\x23\x72\x17\x1A\x61\xE3\x8E\x44\x7F\x3C\xF3\x62\xB3\xAB\xBB\x2E\xD4\x17\x0D\x89\xDC\xB2\x81\x87\xB7\xBF\xD2\x06\xA3\xE0\x26\xF0\x84\xA7\xE0\xED\x63\xD3\x19\xDE\x6B\xC9\xAF\xC0"
        )
    ,
        ( 20
        , "\x67\x99\xD7\x6E\x5F\xFB\x5B\x49\x20\xBC\x27\x68\xBA\xFD\x3F\x8C\x16\x55\x4E\x65\xEF\xCF\x9A\x16\xF4\x68\x3A\x7A\x06\x92\x7C\x11"
        , "\x61\xAB\x95\x19\x21\xE5\x4F\xF0\x6D\x9B\x77\xF3\x13\xA4\xE4\x9D\xF7\xA0\x57\xD5\xFD\x62\x79\x89"
        , "\x47\x27\x66"
        , "\x8F\xD7\xDF"
        )
    ,
        ( 20
        , "\xF6\x82\x38\xC0\x83\x65\xBB\x29\x3D\x26\x98\x0A\x60\x64\x88\xD0\x9C\x2F\x10\x9E\xDA\xFA\x0B\xBA\xE9\x93\x7B\x5C\xC2\x19\xA4\x9C"
        , "\x51\x90\xB5\x1E\x9B\x70\x86\x24\x82\x0B\x5A\xBD\xF4\xE4\x0F\xAD\x1F\xB9\x50\xAD\x1A\xDC\x2D\x26"
        , "\x47\xEC\x6B\x1F\x73\xC4\xB7\xFF\x52\x74\xA0\xBF\xD7\xF4\x5F\x86\x48\x12\xC8\x5A\x12\xFB\xCB\x3C\x2C\xF8\xA3\xE9\x0C\xF6\x6C\xCF\x2E\xAC\xB5\x21\xE7\x48\x36\x3C\x77\xF5\x2E\xB4\x26\xAE\x57\xA0\xC6\xC7\x8F\x75\xAF\x71\x28\x45\x69\xE7\x9D\x1A\x92\xF9\x49\xA9\xD6\x9C\x4E\xFC\x0B\x69\x90\x2F\x1E\x36\xD7\x56\x27\x65\x54\x3E\x2D\x39\x42\xD9\xF6\xFF\x59\x48\xD8\xA3\x12\xCF\xF7\x2C\x1A\xFD\x9E\xA3\x08\x8A\xFF\x76\x40\xBF\xD2\x65\xF7\xA9\x94\x6E\x60\x6A\xBC\x77\xBC\xED\xAE\x6B\xDD\xC7\x5A\x0D\xBA\x0B\xD9\x17\xD7\x3E\x3B\xD1\x26\x8F\x72\x7E\x00\x96\x34\x5D\xA1\xED\x25\xCF\x55\x3E\xA7\xA9\x8F\xEA\x6B\x6F\x28\x57\x32\xDE\x37\x43\x15\x61\xEE\x1B\x30\x64\x88\x7F\xBC\xBD\x71\x93\x5E\x02"
        , "\x36\x16\x0E\x88\xD3\x50\x05\x29\xBA\x4E\xDB\xA1\x7B\xC2\x4D\x8C\xFA\xCA\x9A\x06\x80\xB3\xB1\xFC\x97\xCF\x03\xF3\x67\x5B\x7A\xC3\x01\xC8\x83\xA6\x8C\x07\x1B\xC5\x4A\xCD\xD3\xB6\x3A\xF4\xA2\xD7\x2F\x98\x5E\x51\xF9\xD6\x0A\x4C\x7F\xD4\x81\xAF\x10\xB2\xFC\x75\xE2\x52\xFD\xEE\x7E\xA6\xB6\x45\x31\x90\x61\x7D\xCC\x6E\x2F\xE1\xCD\x56\x58\x5F\xC2\xF0\xB0\xE9\x7C\x5C\x3F\x8A\xD7\xEB\x4F\x31\xBC\x48\x90\xC0\x38\x82\xAA\xC2\x4C\xC5\x3A\xCC\x19\x82\x29\x65\x26\x69\x0A\x22\x02\x71\xC2\xF6\xE3\x26\x75\x0D\x3F\xBD\xA5\xD5\xB6\x35\x12\xC8\x31\xF6\x78\x30\xF5\x9A\xC4\x9A\xAE\x33\x0B\x3E\x0E\x02\xC9\xEA\x00\x91\xD1\x98\x41\xF1\xB0\xE1\x3D\x69\xC9\xFB\xFE\x8A\x12\xD6\xF3\x0B\xB7\x34\xD9\xD2"
        )
    ,
        ( 20
        , "\x45\xB2\xBD\x0D\xE4\xED\x92\x93\xEC\x3E\x26\xC4\x84\x0F\xAA\xF6\x4B\x7D\x61\x9D\x51\xE9\xD7\xA2\xC7\xE3\x6C\x83\xD5\x84\xC3\xDF"
        , "\x54\x6C\x8C\x5D\x6B\xE8\xF9\x09\x52\xCA\xB3\xF3\x6D\x7C\x19\x57\xBA\xAA\x7A\x59\xAB\xE3\xD7\xE5"
        , "\x50\x07\xC8\xCD\x5B\x3C\x40\xE1\x7D\x7F\xE4\x23\xA8\x7A\xE0\xCE\xD8\x6B\xEC\x1C\x39\xDC\x07\xA2\x57\x72\xF3\xE9\x6D\xAB\xD5\x6C\xD3\xFD\x73\x19\xF6\xC9\x65\x49\x25\xF2\xD8\x70\x87\xA7\x00\xE1\xB1\x30\xDA\x79\x68\x95\xD1\xC9\xB9\xAC\xD6\x2B\x26\x61\x44\x06\x7D\x37\x3E\xD5\x1E\x78\x74\x98\xB0\x3C\x52\xFA\xAD\x16\xBB\x38\x26\xFA\x51\x1B\x0E\xD2\xA1\x9A\x86\x63\xF5\xBA\x2D\x6E\xA7\xC3\x8E\x72\x12\xE9\x69\x7D\x91\x48\x6C\x49\xD8\xA0\x00\xB9\xA1\x93\x5D\x6A\x7F\xF7\xEF\x23\xE7\x20\xA4\x58\x55\x48\x14\x40\x46\x3B\x4A\xC8\xC4\xF6\xE7\x06\x2A\xDC\x1F\x1E\x1E\x25\xD3\xD6\x5A\x31\x81\x2F\x58\xA7\x11\x60"
        , "\x8E\xAC\xFB\xA5\x68\x89\x8B\x10\xC0\x95\x7A\x7D\x44\x10\x06\x85\xE8\x76\x3A\x71\xA6\x9A\x8D\x16\xBC\x7B\x3F\x88\x08\x5B\xB9\xA2\xF0\x96\x42\xE4\xD0\x9A\x9F\x0A\xD0\x9D\x0A\xAD\x66\xB2\x26\x10\xC8\xBD\x02\xFF\x66\x79\xBB\x92\xC2\xC0\x26\xA2\x16\xBF\x42\x5C\x6B\xE3\x5F\xB8\xDA\xE7\xFF\x0C\x72\xB0\xEF\xD6\xA1\x80\x37\xC7\x0E\xED\x0C\xA9\x00\x62\xA4\x9A\x3C\x97\xFD\xC9\x0A\x8F\x9C\x2E\xA5\x36\xBF\xDC\x41\x91\x8A\x75\x82\xC9\x92\x7F\xAE\x47\xEF\xAA\x3D\xC8\x79\x67\xB7\x88\x7D\xEE\x1B\xF0\x71\x73\x4C\x76\x65\x90\x1D\x91\x05\xDA\xE2\xFD\xF6\x6B\x49\x18\xE5\x1D\x8F\x4A\x48\xC6\x0D\x19\xFB\xFB\xBC\xBA"
        )
    ,
        ( 20
        , "\xFE\x55\x9C\x9A\x28\x2B\xEB\x40\x81\x4D\x01\x6D\x6B\xFC\xB2\xC0\xC0\xD8\xBF\x07\x7B\x11\x10\xB8\x70\x3A\x3C\xE3\x9D\x70\xE0\xE1"
        , "\xB0\x76\x20\x0C\xC7\x01\x12\x59\x80\x5E\x18\xB3\x04\x09\x27\x54\x00\x27\x23\xEB\xEC\x5D\x62\x00"
        , "\x6D\xB6\x5B\x9E\xC8\xB1\x14\xA9\x44\x13\x7C\x82\x1F\xD6\x06\xBE\x75\x47\x8D\x92\x83\x66\xD5\x28\x40\x96\xCD\xEF\x78\x2F\xCF\xF7\xE8\xF5\x9C\xB8\xFF\xCD\xA9\x79\x75\x79\x02\xC5\xFF\xA6\xBC\x47\x7C\xEA\xA4\xCB\x5D\x5E\xA7\x6F\x94\xD9\x1E\x83\x3F\x82\x3A\x6B\xC7\x8F\x10\x55\xDF\xA6\xA9\x7B\xEA\x89\x65\xC1\xCD\xE6\x7A\x66\x8E\x00\x12\x57\x33\x4A\x58\x57\x27\xD9\xE0\xF7\xC1\xA0\x6E\x88\xD3\xD2\x5A\x4E\x6D\x90\x96\xC9\x68\xBF\x13\x8E\x11\x6A\x3E\xBE\xFF\xD4\xBB\x48\x08\xAD\xB1\xFD\x69\x81\x64\xBA\x0A\x35\xC7\x09\xA4\x7F\x16\xF1\xF4\x43\x5A\x23\x45\xA9\x19\x4A\x00\xB9\x5A\xBD\x51\x85\x1D\x50\x58\x09\xA6\x07\x7D\xA9\xBA\xCA\x58\x31\xAF\xFF\x31\x57\x8C\x48\x7E\xE6\x8F\x27\x67\x97\x4A\x98\xA7\xE8\x03\xAA\xC7\x88\xDA\x98\x31\x9C\x4E\xA8\xEA\xA3\xD3\x94\x85\x56\x51\xF4\x84\xCE\xF5\x43\xF5\x37\xE3\x51\x58\xEE\x29"
        , "\x4D\xCE\x9C\x8F\x97\xA0\x28\x05\x1B\x07\x27\xF3\x4E\x1B\x9E\xF2\x1F\x06\xF0\x76\x0F\x36\xE7\x17\x13\x20\x40\x27\x90\x20\x90\xBA\x2B\xB6\xB1\x34\x36\xEE\x77\x8D\x9F\x50\x53\x0E\xFB\xD7\xA3\x2B\x0D\x41\x44\x3F\x58\xCC\xAE\xE7\x81\xC7\xB7\x16\xD3\xA9\x6F\xDE\xC0\xE3\x76\x4E\xD7\x95\x9F\x34\xC3\x94\x12\x78\x59\x1E\xA0\x33\xB5\xCB\xAD\xC0\xF1\x91\x60\x32\xE9\xBE\xBB\xD1\xA8\x39\x5B\x83\xFB\x63\xB1\x45\x4B\xD7\x75\xBD\x20\xB3\xA2\xA9\x6F\x95\x12\x46\xAC\x14\xDA\xF6\x81\x66\xBA\x62\xF6\xCB\xFF\x8B\xD1\x21\xAC\x94\x98\xFF\x88\x52\xFD\x2B\xE9\x75\xDF\x52\xB5\xDA\xEF\x38\x29\xD1\x8E\xDA\x42\xE7\x15\x02\x2D\xCB\xF9\x30\xD0\xA7\x89\xEE\x6A\x14\x6C\x2C\x70\x88\xC3\x57\x73\xC6\x3C\x06\xB4\xAF\x45\x59\x85\x6A\xC1\x99\xCE\xD8\x68\x63\xE4\x29\x47\x07\x82\x53\x37\xC5\x85\x79\x70\xEB\x7F\xDD\xEB\x26\x37\x81\x30\x90\x11"
        )
    ,
        ( 20
        , "\x0A\xE1\x00\x12\xD7\xE5\x66\x14\xB0\x3D\xCC\x89\xB1\x4B\xAE\x92\x42\xFF\xE6\x30\xF3\xD7\xE3\x5C\xE8\xBB\xB9\x7B\xBC\x2C\x92\xC3"
        , "\xF9\x6B\x02\x5D\x6C\xF4\x6A\x8A\x12\xAC\x2A\xF1\xE2\xAE\xF1\xFB\x83\x59\x0A\xDA\xDA\xA5\xC5\xEA"
        , "\xEA\x0F\x35\x4E\x96\xF1\x2B\xC7\x2B\xBA\xA3\xD1\x2B\x4A\x8E\xD8\x79\xB0\x42\xF0\x68\x98\x78\xF4\x6B\x65\x1C\xC4\x11\x6D\x6F\x78\x40\x9B\x11\x43\x0B\x3A\xAA\x30\xB2\x07\x68\x91\xE8\xE1\xFA\x52\x8F\x2F\xD1\x69\xED\x93\xDC\x9F\x84\xE2\x44\x09\xEE\xC2\x10\x1D\xAF\x4D\x05\x7B\xE2\x49\x2D\x11\xDE\x64\x0C\xBD\x7B\x35\x5A\xD2\x9F\xB7\x04\x00\xFF\xFD\x7C\xD6\xD4\x25\xAB\xEE\xB7\x32\xA0\xEA\xA4\x33\x0A\xF4\xC6\x56\x25\x2C\x41\x73\xDE\xAB\x65\x3E\xB8\x5C\x58\x46\x2D\x7A\xB0\xF3\x5F\xD1\x2B\x61\x3D\x29\xD4\x73\xD3\x30\x31\x0D\xC3\x23\xD3\xC6\x63\x48\xBB\xDB\xB6\x8A\x32\x63\x24\x65\x7C\xAE\x7B\x77\xA9\xE3\x43\x58\xF2\xCE\xC5\x0C\x85\x60\x9E\x73\x05\x68\x56\x79\x6E\x3B\xE8\xD6\x2B\x6E\x2F\xE9\xF9\x53"
        , "\xE8\xAB\xD4\x89\x24\xB5\x4E\x5B\x80\x86\x6B\xE7\xD4\xEB\xE5\xCF\x42\x74\xCA\xFF\xF0\x8B\x39\xCB\x2D\x40\xA8\xF0\xB4\x72\x39\x8A\xED\xC7\x76\xE0\x79\x38\x12\xFB\xF1\xF6\x00\x78\x63\x5D\x2E\xD8\x6B\x15\xEF\xCD\xBA\x60\x41\x1E\xE2\x3B\x07\x23\x35\x92\xA4\x4E\xC3\x1B\x10\x13\xCE\x89\x64\x23\x66\x75\xF8\xF1\x83\xAE\xF8\x85\xE8\x64\xF2\xA7\x2E\xDF\x42\x15\xB5\x33\x8F\xA2\xB5\x46\x53\xDF\xA1\xA8\xC5\x5C\xE5\xD9\x5C\xC6\x05\xB9\xB3\x11\x52\x7F\x2E\x34\x63\xFF\xBE\xC7\x8A\x9D\x1D\x65\xDA\xBA\xD2\xF3\x38\x76\x9C\x9F\x43\xF1\x33\xA7\x91\xA1\x1C\x7E\xCA\x9A\xF0\xB7\x71\xA4\xAC\x32\x96\x3D\xC8\xF6\x31\xA2\xC1\x12\x17\xAC\x6E\x1B\x94\x30\xC1\xAA\xE1\xCE\xEB\xE2\x27\x03\xF4\x29\x99\x8A\x8F\xB8\xC6\x41"
        )
    ,
        ( 20
        , "\x08\x2C\x53\x9B\xC5\xB2\x0F\x97\xD7\x67\xCD\x3F\x22\x9E\xDA\x80\xB2\xAD\xC4\xFE\x49\xC8\x63\x29\xB5\xCD\x62\x50\xA9\x87\x74\x50"
        , "\x84\x55\x43\x50\x2E\x8B\x64\x91\x2D\x8F\x2C\x8D\x9F\xFF\xB3\xC6\x93\x65\x68\x65\x87\xC0\x8D\x0C"
        , "\xA9\x6B\xB7\xE9\x10\x28\x1A\x6D\xFA\xD7\xC8\xA9\xC3\x70\x67\x4F\x0C\xEE\xC1\xAD\x8D\x4F\x0D\xE3\x2F\x9A\xE4\xA2\x3E\xD3\x29\xE3\xD6\xBC\x70\x8F\x87\x66\x40\xA2\x29\x15\x3A\xC0\xE7\x28\x1A\x81\x88\xDD\x77\x69\x51\x38\xF0\x1C\xDA\x5F\x41\xD5\x21\x5F\xD5\xC6\xBD\xD4\x6D\x98\x2C\xB7\x3B\x1E\xFE\x29\x97\x97\x0A\x9F\xDB\xDB\x1E\x76\x8D\x7E\x5D\xB7\x12\x06\x8D\x8B\xA1\xAF\x60\x67\xB5\x75\x34\x95\xE2\x3E\x6E\x19\x63\xAF\x01\x2F\x9C\x7C\xE4\x50\xBF\x2D\xE6\x19\xD3\xD5\x95\x42\xFB\x55\xF3"
        , "\x83\x5D\xA7\x4F\xC6\xDE\x08\xCB\xDA\x27\x7A\x79\x66\xA0\x7C\x8D\xCD\x62\x7E\x7B\x17\xAD\xDE\x6D\x93\x0B\x65\x81\xE3\x12\x4B\x8B\xAA\xD0\x96\xF6\x93\x99\x1F\xED\xB1\x57\x29\x30\x60\x1F\xC7\x70\x95\x41\x83\x9B\x8E\x3F\xFD\x5F\x03\x3D\x20\x60\xD9\x99\xC6\xC6\xE3\x04\x82\x76\x61\x3E\x64\x80\x00\xAC\xB5\x21\x2C\xC6\x32\xA9\x16\xAF\xCE\x29\x0E\x20\xEB\xDF\x61\x2D\x08\xA6\xAA\x4C\x79\xA7\x4B\x07\x0D\x3F\x87\x2A\x86\x1F\x8D\xC6\xBB\x07\x61\x4D\xB5\x15\xD3\x63\x34\x9D\x3A\x8E\x33\x36\xA3"
        )
    ,
        ( 20
        , "\x3D\x02\xBF\xF3\x37\x5D\x40\x30\x27\x35\x6B\x94\xF5\x14\x20\x37\x37\xEE\x9A\x85\xD2\x05\x2D\xB3\xE4\xE5\xA2\x17\xC2\x59\xD1\x8A"
        , "\x74\x21\x6C\x95\x03\x18\x95\xF4\x8C\x1D\xBA\x65\x15\x55\xEB\xFA\x3C\xA3\x26\xA7\x55\x23\x70\x25"
        , "\x0D\x4B\x0F\x54\xFD\x09\xAE\x39\xBA\xA5\xFA\x4B\xAC\xCF\x2E\x66\x82\xE6\x1B\x25\x7E\x01\xF4\x2B\x8F"
        , "\x16\xC4\x00\x6C\x28\x36\x51\x90\x41\x1E\xB1\x59\x38\x14\xCF\x15\xE7\x4C\x22\x23\x8F\x21\x0A\xFC\x3D"
        )
    ,
        ( 20
        , "\xAD\x1A\x5C\x47\x68\x88\x74\xE6\x66\x3A\x0F\x3F\xA1\x6F\xA7\xEF\xB7\xEC\xAD\xC1\x75\xC4\x68\xE5\x43\x29\x14\xBD\xB4\x80\xFF\xC6"
        , "\xE4\x89\xEE\xD4\x40\xF1\xAA\xE1\xFA\xC8\xFB\x7A\x98\x25\x63\x54\x54\xF8\xF8\xF1\xF5\x2E\x2F\xCC"
        , "\xAA\x6C\x1E\x53\x58\x0F\x03\xA9\xAB\xB7\x3B\xFD\xAD\xED\xFE\xCA\xDA\x4C\x6B\x0E\xBE\x02\x0E\xF1\x0D\xB7\x45\xE5\x4B\xA8\x61\xCA\xF6\x5F\x0E\x40\xDF\xC5\x20\x20\x3B\xB5\x4D\x29\xE0\xA8\xF7\x8F\x16\xB3\xF1\xAA\x52\x5D\x6B\xFA\x33\xC5\x47\x26\xE5\x99\x88\xCF\xBE\xC7\x80\x56"
        , "\x02\xFE\x84\xCE\x81\xE1\x78\xE7\xAA\xBD\xD3\xBA\x92\x5A\x76\x6C\x3C\x24\x75\x6E\xEF\xAE\x33\x94\x2A\xF7\x5E\x8B\x46\x45\x56\xB5\x99\x7E\x61\x6F\x3F\x2D\xFC\x7F\xCE\x91\x84\x8A\xFD\x79\x91\x2D\x9F\xB5\x52\x01\xB5\x81\x3A\x5A\x07\x4D\x2C\x0D\x42\x92\xC1\xFD\x44\x18\x07\xC5"
        )
    ,
        ( 20
        , "\x05\x3A\x02\xBE\xDD\x63\x68\xC1\xFB\x8A\xFC\x7A\x1B\x19\x9F\x7F\x7E\xA2\x22\x0C\x9A\x4B\x64\x2A\x68\x50\x09\x1C\x9D\x20\xAB\x9C"
        , "\xC7\x13\xEE\xA5\xC2\x6D\xAD\x75\xAD\x3F\x52\x45\x1E\x00\x3A\x9C\xB0\xD6\x49\xF9\x17\xC8\x9D\xDE"
        , "\x8F\x0A\x8A\x16\x47\x60\x42\x65\x67\xE3\x88\x84\x02\x76\xDE\x3F\x95\xCB\x5E\x3F\xAD\xC6\xED\x3F\x3E\x4F\xE8\xBC\x16\x9D\x93\x88\x80\x4D\xCB\x94\xB6\x58\x7D\xBB\x66\xCB\x0B\xD5\xF8\x7B\x8E\x98\xB5\x2A\xF3\x7B\xA2\x90\x62\x9B\x85\x8E\x0E\x2A\xA7\x37\x80\x47\xA2\x66\x02"
        , "\x51\x67\x10\xE5\x98\x43\xE6\xFB\xD4\xF2\x5D\x0D\x8C\xA0\xEC\x0D\x47\xD3\x9D\x12\x5E\x9D\xAD\x98\x7E\x05\x18\xD4\x91\x07\x01\x4C\xB0\xAE\x40\x5E\x30\xC2\xEB\x37\x94\x75\x0B\xCA\x14\x2C\xE9\x5E\x29\x0C\xF9\x5A\xBE\x15\xE8\x22\x82\x3E\x2E\x7D\x3A\xB2\x1B\xC8\xFB\xD4\x45"
        )
    ,
        ( 20
        , "\x5B\x14\xAB\x0F\xBE\xD4\xC5\x89\x52\x54\x8A\x6C\xB1\xE0\x00\x0C\xF4\x48\x14\x21\xF4\x12\x88\xEA\x0A\xA8\x4A\xDD\x9F\x7D\xEB\x96"
        , "\x54\xBF\x52\xB9\x11\x23\x1B\x95\x2B\xA1\xA6\xAF\x8E\x45\xB1\xC5\xA2\x9D\x97\xE2\xAB\xAD\x7C\x83"
        , "\x37\xFB\x44\xA6\x75\x97\x8B\x56\x0F\xF9\xA4\xA8\x70\x11\xD6\xF3\xAD\x2D\x37\xA2\xC3\x81\x5B\x45\xA3\xC0\xE6\xD1\xB1\xD8\xB1\x78\x4C\xD4\x68\x92\x7C\x2E\xE3\x9E\x1D\xCC\xD4\x76\x5E\x1C\x3D\x67\x6A\x33\x5B\xE1\xCC\xD6\x90\x0A\x45\xF5\xD4\x1A\x31\x76\x48\x31\x5D\x8A\x8C\x24\xAD\xC6\x4E\xB2\x85\xF6\xAE\xBA\x05\xB9\x02\x95\x86\x35\x3D\x30\x3F\x17\xA8\x07\x65\x8B\x9F\xF7\x90\x47\x4E\x17\x37\xBD\x5F\xDC\x60\x4A\xEF\xF8\xDF\xCA\xF1\x42\x7D\xCC\x3A\xAC\xBB\x02\x56\xBA\xDC\xD1\x83\xED\x75\xA2\xDC\x52\x45\x2F\x87\xD3\xC1\xED\x2A\xA5\x83\x47\x2B\x0A\xB9\x1C\xDA\x20\x61\x4E\x9B\x6F\xDB\xDA\x3B\x49\xB0\x98\xC9\x58\x23\xCC\x72\xD8\xE5\xB7\x17\xF2\x31\x4B\x03\x24\xE9\xCE"
        , "\xAE\x6D\xEB\x5D\x6C\xE4\x3D\x4B\x09\xD0\xE6\xB1\xC0\xE9\xF4\x61\x57\xBC\xD8\xAB\x50\xEA\xA3\x19\x7F\xF9\xFA\x2B\xF7\xAF\x64\x9E\xB5\x2C\x68\x54\x4F\xD3\xAD\xFE\x6B\x1E\xB3\x16\xF1\xF2\x35\x38\xD4\x70\xC3\x0D\xBF\xEC\x7E\x57\xB6\x0C\xBC\xD0\x96\xC7\x82\xE7\x73\x6B\x66\x91\x99\xC8\x25\x3E\x70\x21\x4C\xF2\xA0\x98\xFD\xA8\xEA\xC5\xDA\x79\xA9\x49\x6A\x3A\xAE\x75\x4D\x03\xB1\x7C\x6D\x70\xD1\x02\x7F\x42\xBF\x7F\x95\xCE\x3D\x1D\x9C\x33\x88\x54\xE1\x58\xFC\xC8\x03\xE4\xD6\x26\x2F\xB6\x39\x52\x1E\x47\x11\x6E\xF7\x8A\x7A\x43\x7C\xA9\x42\x7B\xA6\x45\xCD\x64\x68\x32\xFE\xAB\x82\x2A\x20\x82\x78\xE4\x5E\x93\xE1\x18\xD7\x80\xB9\x88\xD6\x53\x97\xED\xDF\xD7\xA8\x19\x52\x6E"
        )
    ,
        ( 20
        , "\xD7\x46\x36\xE3\x41\x3A\x88\xD8\x5F\x32\x2C\xA8\x0F\xB0\xBD\x65\x0B\xD0\xBF\x01\x34\xE2\x32\x91\x60\xB6\x96\x09\xCD\x58\xA4\xB0"
        , "\xEF\xB6\x06\xAA\x1D\x9D\x9F\x0F\x46\x5E\xAA\x7F\x81\x65\xF1\xAC\x09\xF5\xCB\x46\xFE\xCF\x2A\x57"
        , "\xF8\x54\x71\xB7\x5F\x6E\xC8\x1A\xBA\xC2\x79\x9E\xC0\x9E\x98\xE2\x80\xB2\xFF\xD6\x4C\xA2\x85\xE5\xA0\x10\x9C\xFB\x31\xFF\xAB\x2D\x61\x7B\x2C\x29\x52\xA2\xA8\xA7\x88\xFC\x0D\xA2\xAF\x7F\x53\x07\x58\xF7\x4F\x1A\xB5\x63\x91\xAB\x5F\xF2\xAD\xBC\xC5\xBE\x2D\x6C\x7F\x49\xFB\xE8\x11\x81\x04\xC6\xFF\x9A\x23\xC6\xDF\xE5\x2F\x57\x95\x4E\x6A\x69\xDC\xEE\x5D\xB0\x6F\x51\x4F\x4A\x0A\x57\x2A\x9A\x85\x25\xD9\x61\xDA\xE7\x22\x69\xB9\x87\x18\x9D\x46\x5D\xF6\x10\x71\x19\xC7\xFA\x79\x08\x53\xE0\x63\xCB\xA0\xFA\xB7\x80\x0C\xA9\x32\xE2\x58\x88\x0F\xD7\x4C\x33\xC7\x84\x67\x5B\xED\xAD\x0E\x7C\x09\xE9\xCC\x4D\x63\xDD\x5E\x97\x13\xD5\xD4\xA0\x19\x6E\x6B\x56\x22\x26\xAC\x31\xB4\xF5\x7C\x04\xF9\x0A\x18\x19\x73\x73\x7D\xDC\x7E\x80\xF3\x64\x11\x2A\x9F\xBB\x43\x5E\xBD\xBC\xAB\xF7\xD4\x90\xCE\x52"
        , "\xB2\xB7\x95\xFE\x6C\x1D\x4C\x83\xC1\x32\x7E\x01\x5A\x67\xD4\x46\x5F\xD8\xE3\x28\x13\x57\x5C\xBA\xB2\x63\xE2\x0E\xF0\x58\x64\xD2\xDC\x17\xE0\xE4\xEB\x81\x43\x6A\xDF\xE9\xF6\x38\xDC\xC1\xC8\xD7\x8F\x6B\x03\x06\xBA\xF9\x38\xE5\xD2\xAB\x0B\x3E\x05\xE7\x35\xCC\x6F\xFF\x2D\x6E\x02\xE3\xD6\x04\x84\xBE\xA7\xC7\xA8\xE1\x3E\x23\x19\x7F\xEA\x7B\x04\xD4\x7D\x48\xF4\xA4\xE5\x94\x41\x74\x53\x94\x92\x80\x0D\x3E\xF5\x1E\x2E\xE5\xE4\xC8\xA0\xBD\xF0\x50\xC2\xDD\x3D\xD7\x4F\xCE\x5E\x7E\x5C\x37\x36\x4F\x75\x47\xA1\x14\x80\xA3\x06\x3B\x9A\x0A\x15\x7B\x15\xB1\x0A\x5A\x95\x4D\xE2\x73\x1C\xED\x05\x5A\xA2\xE2\x76\x7F\x08\x91\xD4\x32\x9C\x42\x6F\x38\x08\xEE\x86\x7B\xED\x0D\xC7\x5B\x59\x22\xB7\xCF\xB8\x95\x70\x0F\xDA\x01\x61\x05\xA4\xC7\xB7\xF0\xBB\x90\xF0\x29\xF6\xBB\xCB\x04\xAC\x36\xAC\x16"
        )
    ]

-- Test vector from paper "Cryptography in NaCl"
vectorsCB :: [Vector]
vectorsCB =
    [
        ( 20
        , "\x4A\x5D\x9D\x5B\xA4\xCE\x2D\xE1\x72\x8E\x3B\xF4\x80\x35\x0F\x25\xE0\x7E\x21\xC9\x47\xD1\x9E\x33\x76\xF0\x9B\x3C\x1E\x16\x17\x42"
        , "\x69\x69\x6E\xE9\x55\xB6\x2B\x73\xCD\x62\xBD\xA8\x75\xFC\x73\xD6\x82\x19\xE0\x03\x6B\x7A\x0B\x37"
        , "\xBE\x07\x5F\xC5\x3C\x81\xF2\xD5\xCF\x14\x13\x16\xEB\xEB\x0C\x7B\x52\x28\xC5\x2A\x4C\x62\xCB\xD4\x4B\x66\x84\x9B\x64\x24\x4F\xFC\xE5\xEC\xBA\xAF\x33\xBD\x75\x1A\x1A\xC7\x28\xD4\x5E\x6C\x61\x29\x6C\xDC\x3C\x01\x23\x35\x61\xF4\x1D\xB6\x6C\xCE\x31\x4A\xDB\x31\x0E\x3B\xE8\x25\x0C\x46\xF0\x6D\xCE\xEA\x3A\x7F\xA1\x34\x80\x57\xE2\xF6\x55\x6A\xD6\xB1\x31\x8A\x02\x4A\x83\x8F\x21\xAF\x1F\xDE\x04\x89\x77\xEB\x48\xF5\x9F\xFD\x49\x24\xCA\x1C\x60\x90\x2E\x52\xF0\xA0\x89\xBC\x76\x89\x70\x40\xE0\x82\xF9\x37\x76\x38\x48\x64\x5E\x07\x05"
        , "\x8E\x99\x3B\x9F\x48\x68\x12\x73\xC2\x96\x50\xBA\x32\xFC\x76\xCE\x48\x33\x2E\xA7\x16\x4D\x96\xA4\x47\x6F\xB8\xC5\x31\xA1\x18\x6A\xC0\xDF\xC1\x7C\x98\xDC\xE8\x7B\x4D\xA7\xF0\x11\xEC\x48\xC9\x72\x71\xD2\xC2\x0F\x9B\x92\x8F\xE2\x27\x0D\x6F\xB8\x63\xD5\x17\x38\xB4\x8E\xEE\xE3\x14\xA7\xCC\x8A\xB9\x32\x16\x45\x48\xE5\x26\xAE\x90\x22\x43\x68\x51\x7A\xCF\xEA\xBD\x6B\xB3\x73\x2B\xC0\xE9\xDA\x99\x83\x2B\x61\xCA\x01\xB6\xDE\x56\x24\x4A\x9E\x88\xD5\xF9\xB3\x79\x73\xF6\x22\xA4\x3D\x14\xA6\x59\x9B\x1F\x65\x4C\xB4\x5A\x74\xE3\x55\xA5"
        )
    ]

tests =
    testGroup
        "XSalsa"
        [ testGroup "KAT" $
            zipWith
                (\i (r, k, n, p, e) -> testCase (show (i :: Int)) $ salsaRunSimple r k n p e)
                [1 ..]
                vectors
        , testGroup "crypto_box encryption" $
            zipWith
                (\i (r, k, n, p, e) -> testCase (show (i :: Int)) $ cryptoBoxEnc r k n p e)
                [1 ..]
                vectorsCB
        ]
  where
    salsaRunSimple rounds key nonce plain expected =
        let salsa = XSalsa.initialize rounds key nonce
         in fst (XSalsa.combine salsa plain) @?= expected

    cryptoBoxEnc rounds shared nonce plain expected =
        let zero = B.replicate 16 0
            (iv0, iv1) = B.splitAt 8 nonce
            salsa0 = XSalsa.initialize rounds shared (zero `B.append` iv0)
            salsa1 = XSalsa.derive salsa0 iv1
            (_, salsa2) = XSalsa.generate salsa1 32 :: (B.ByteString, XSalsa.State)
         in fst (XSalsa.combine salsa2 plain) @?= expected

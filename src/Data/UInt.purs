-- | This module provides 32-bit unsigned integers. Provided type `UInt`
-- | is based on the `x >>> 0` trick analogous to how PureScript's `Int`
-- | is based on `x | 0` trick.
-- | The type has range from 0 to 4294967295.
module Data.UInt
     ( UInt
     , fromInt
     , fromInt'
     , toInt
     , toInt'
     , fromNumber
     , fromNumber'
     , toNumber
     , floor
     , ceil
     , round
     , pow
     , toString
     , fromString
     ) where

import Data.Maybe (Maybe(..))
import Data.Semiring (class Semiring)
import Data.Ring (class Ring, negate)
import Data.CommutativeRing (class CommutativeRing)
import Data.EuclideanRing (class EuclideanRing, mod)
import Data.Eq (class Eq, (==))
import Data.Ord (class Ord, Ordering(..), clamp)
import Data.Bounded (class Bounded, top, bottom)
import Data.Show (class Show)
import Data.Function ((<<<))
import Data.Semigroup ((<>))
import Math as Math

foreign import data UInt :: *

foreign import exact :: forall a b. (b -> Maybe b) -> Maybe b -> (a -> b) -> a -> Maybe b
foreign import from :: forall a. a -> UInt

fromInt :: Int -> UInt
fromInt = from

fromInt' :: Int -> Maybe UInt
fromInt' = exact Just Nothing fromInt

foreign import toInt :: UInt -> Int

toInt' :: UInt -> Maybe Int
toInt' = exact Just Nothing toInt

foreign import uintAdd :: UInt -> UInt -> UInt
foreign import uintMul :: UInt -> UInt -> UInt

instance uintSemiring :: Semiring UInt where
  zero = fromInt 0
  add = uintAdd
  one = fromInt 1
  mul = uintMul

foreign import uintSub :: UInt -> UInt -> UInt

instance uintRing :: Ring UInt where
  sub = uintSub

instance uintCommutativeRing :: CommutativeRing UInt

foreign import uintDiv :: UInt -> UInt -> UInt
foreign import uintMod :: UInt -> UInt -> UInt
foreign import uintDegree :: UInt -> Int

instance uintEulideanRing :: EuclideanRing UInt where
  div = uintDiv
  mod = uintMod
  degree = uintDegree

foreign import uintEq :: UInt -> UInt -> Boolean

instance uintEqInstance :: Eq UInt where
  eq = uintEq

foreign import uintCmp :: Ordering -> Ordering -> Ordering -> UInt -> UInt -> Ordering

instance uintOrd :: Ord UInt where
  compare = uintCmp LT EQ GT

foreign import fromStringImpl :: String -> Number

fromString :: String -> Maybe UInt
fromString = fromNumber' <<< fromStringImpl

-- | Converts an `UInt` to a `String`.
-- |
-- | There is also a `Show` instance (so you can use `show`), but that
-- | appends `u` suffix, which isn't always what you'll want.
-- |
-- |      toString (fromInt 42) == "42"
-- |      show (fromInt 42) == "42u"
foreign import toString :: UInt -> String

instance uintShowInstance :: Show UInt where
  show u = toString u <> "u"

instance uintBounded :: Bounded UInt where
  bottom = fromInt 0
  top = fromInt (-1)

fromNumber :: Number -> UInt
fromNumber = from

fromNumber' :: Number -> Maybe UInt
fromNumber' = exact Just Nothing fromNumber

foreign import toNumber :: UInt -> Number

clamp' :: Number -> Number
clamp' = clamp (toNumber bottom) (toNumber top)

floor :: Number -> UInt
floor = fromNumber <<< Math.floor <<< clamp'

ceil :: Number -> UInt
ceil = fromNumber <<< Math.ceil <<< clamp'

round :: Number -> UInt
round = fromNumber <<< Math.round <<< clamp'

even :: UInt -> Boolean
even u = u `mod` (fromInt 2) == (fromInt 0)

odd :: UInt -> Boolean
odd u = u `mod` (fromInt 2) == (fromInt 1)

foreign import pow :: UInt -> UInt -> UInt

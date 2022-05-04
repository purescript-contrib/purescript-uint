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
  , even
  , odd
  , pow
  , and
  , (.&.)
  , or
  , (.|.)
  , xor
  , (.^.)
  , shl
  , shr
  , zshr
  , complement
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
import Data.Enum (class Enum)
import Prelude ((<), (>), (+), (-))
import Data.Number (ceil, floor, round) as Number

-- | 32-bit unsigned integer. Range from *0* to *4294967295*.
newtype UInt = UInt Number

foreign import exact :: forall a b. (b -> Maybe b) -> Maybe b -> (a -> b) -> a -> Maybe b
foreign import from :: forall a. a -> UInt

instance enumUInt :: Enum UInt where
  succ n = if n < top then Just (n + fromInt 1) else Nothing
  pred n = if n > bottom then Just (n - fromInt 1) else Nothing

-- | Cast an `Int` to an `UInt` turning negative `Int`s into `UInt`s
-- | in range from `2^31` to `2^32-1`.
-- |
-- |     > fromInt 123
-- |     123u
-- |
-- |     > fromInt (-123)
-- |     4294967173u
fromInt :: Int -> UInt
fromInt = from

-- | Converts positive `Int`s into `UInt`. Returns `Nothing` for
-- | negative `Int`s
-- |
-- |     > fromInt' 123
-- |     (Just 123u)
-- |
-- |     > fromInt' (-123)
-- |     Nothing
fromInt' :: Int -> Maybe UInt
fromInt' = exact Just Nothing fromInt

-- | Cast an `UInt` to an `Int` turning `UInt`s in range from `2^31`
-- | to `2^32-1` into negative `Int`s.
-- |
-- |     > toInt (fromInt 123)
-- |     123
-- |
-- |     > toInt (fromInt (-1))
-- |     -1
foreign import toInt :: UInt -> Int

-- | Converts `UInt`s in range from `0` to `2^31-1` into `Int`s. Returns
-- | `Nothing` for `UInt`'s in range from `2^31` to `2^32-1`.
-- |
-- |     > toInt' (fromInt 123)
-- |     (Just 123)
-- |
-- |     > toInt' (fromInt (-1))
-- |     Nothing
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

instance uintEuclideanRing :: EuclideanRing UInt where
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

-- | Tries to parse an `UInt` from a `String`.
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

-- | Cast a `Number` `n` to `UInt` by performing 0-bit unsigned right
-- | shift `n >>> 0`.
fromNumber :: Number -> UInt
fromNumber = from

-- | Convert a `Number` which is already an `UInt` to `UInt`. Fails
-- | for non-integers and integers not in range from `0` to `2^32-1`.
fromNumber' :: Number -> Maybe UInt
fromNumber' = exact Just Nothing fromNumber

-- | Cast an `UInt` to a `Number`, which is always safe to do.
foreign import toNumber :: UInt -> Number

clamp' :: Number -> Number
clamp' = clamp (toNumber bottom) (toNumber top)

-- | Convert a `Number` to an `UInt`. Takes the closest integer equal to or
-- | less than the argument. Values outside the `UInt` range are clamped.
-- |
-- |     > floor 27.1
-- |     27u
-- |
-- |     > floor 27.9
-- |     27u
-- |
-- |     > floor (-27.1)
-- |     0u
-- |
-- |     > floor (1.0e65)
-- |     4294967295u
-- |
-- |     > floor (-1.0e65)
-- |     0u
floor :: Number -> UInt
floor = fromNumber <<< Number.floor <<< clamp'

-- | Convert a `Number` to an `UInt`. Takes the closest integer equal to or
-- | greater than the argument. Values outside the `UInt` range are clamped.
-- |
-- |     > ceil 27.1
-- |     28u
-- |
-- |     > ceil 27.9
-- |     28u
-- |
-- |     > ceil (-27.1)
-- |     0u
-- |
-- |     > ceil (1.0e65)
-- |     4294967295u
-- |
-- |     > ceil (-1.0e65)
-- |     0u
ceil :: Number -> UInt
ceil = fromNumber <<< Number.ceil <<< clamp'

-- | Convert a `Number` to an `UInt`, by taking the nearest integer to the
-- | argument. Values outside the `UInt` range are clamped.
-- |
-- |     > round 27.1
-- |     27u
-- |
-- |     > round 27.9
-- |     28u
-- |
-- |     > round (-27.1)
-- |     0u
-- |
-- |     > round (-27.9)
-- |     0u
-- |
-- |     > round (1.0e65)
-- |     4294967295u
-- |
-- |     > round (-1.0e65)
-- |     0u
round :: Number -> UInt
round = fromNumber <<< Number.round <<< clamp'

-- | Returns true if the `UInt` is an even number.
-- |
-- |     > even (fromInt 0)
-- |     true
-- |
-- |     > even (fromInt 1)
-- |     false
even :: UInt -> Boolean
even u = u `mod` (fromInt 2) == (fromInt 0)

-- | Returns true if the `UInt` is an odd number.
-- |
-- |     > odd (fromInt 0)
-- |     false
-- |
-- |     > odd (fromInt 1)
-- |     true
odd :: UInt -> Boolean
odd u = u `mod` (fromInt 2) == (fromInt 1)

-- | Raises the first argument to the power of the second argument (the exponent).
-- |
-- |     > pow (fromInt 2) (fromInt 3)
-- |     8u
foreign import pow :: UInt -> UInt -> UInt

-- | Bitwise AND.
-- |
-- |     > and (fromInt 6) (fromInt 4)
-- |     4u
foreign import and :: UInt -> UInt -> UInt

infixl 10 and as .&.

-- | Bitwise OR.
-- |
-- |     > or (fromInt 4) (fromInt 2)
-- |     6u
foreign import or :: UInt -> UInt -> UInt

infixl 10 or as .|.

-- | Bitwise XOR.
-- |
-- |     > xor (fromInt 6) (fromInt 4)
-- |     0u
foreign import xor :: UInt -> UInt -> UInt

infixl 10 xor as .^.

-- | Bitwise shift left.
-- |
-- |     > shl (fromInt 4) (fromInt 1)
-- |     8u
foreign import shl :: UInt -> UInt -> UInt

-- | Bitwise shift right while preserving sign.
-- |
-- |     > shr (fromInt 4) (fromInt 1)
-- |     2u
foreign import shr :: UInt -> UInt -> UInt

-- | Bitwise zero-fill shift right.
-- |
-- |     > shr (fromInt 4) (fromInt 1)
-- |     2u
foreign import zshr :: UInt -> UInt -> UInt

-- | Bitwise NOT.
-- |
-- |     > complement (fromInt 0xFF...)
-- |     0u
foreign import complement :: UInt -> UInt

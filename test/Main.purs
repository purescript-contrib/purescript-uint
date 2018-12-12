module Test.Main where

import Prelude

import Effect (Effect)
import Data.UInt (UInt, fromNumber)
import Test.QuickCheck.Arbitrary (class Arbitrary, arbitrary)
import Test.QuickCheck.Laws.Data as Data
import Type.Proxy (Proxy(..))

newtype TestUInt = TestUInt UInt

instance arbitraryTestUInt :: Arbitrary TestUInt where
  arbitrary = TestUInt <<< fromNumber <$> arbitrary
derive newtype instance boundedTestUInt :: Bounded TestUInt
derive newtype instance eqTestUInt :: Eq TestUInt
derive newtype instance ordTestUInt :: Ord TestUInt
derive newtype instance semiringTestUInt :: Semiring TestUInt
derive newtype instance ringTestUInt :: Ring TestUInt
derive newtype instance commutativeRingTestUInt :: CommutativeRing TestUInt
derive newtype instance euclideanRingTestUInt :: EuclideanRing TestUInt


main :: Effect Unit
main = do
  let prxUInt = Proxy ∷ Proxy TestUInt
  Data.checkEq prxUInt
  Data.checkOrd prxUInt
  Data.checkSemiring prxUInt
  Data.checkRing prxUInt
  Data.checkEuclideanRing prxUInt
  Data.checkBounded prxUInt
  Data.checkCommutativeRing prxUInt

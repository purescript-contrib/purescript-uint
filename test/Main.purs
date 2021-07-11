module Test.Main where

import Prelude

import Effect (Effect)
import Data.Newtype (class Newtype, over)
import Data.UInt (UInt, and, fromInt, fromNumber)
import Data.UInt.Gen (genUInt)
import Test.QuickCheck (quickCheck, (===))
import Test.QuickCheck.Arbitrary (class Arbitrary)
import Test.QuickCheck.Laws.Data as Data
import Type.Proxy (Proxy(..))

newtype TestUInt = TestUInt UInt

instance newtypeTestUInt :: Newtype TestUInt UInt
instance arbitraryTestUInt :: Arbitrary TestUInt where
  arbitrary = TestUInt <$> genUInt bottom (fromNumber 20000.0)
derive newtype instance boundedTestUInt :: Bounded TestUInt
derive newtype instance eqTestUInt :: Eq TestUInt
derive newtype instance ordTestUInt :: Ord TestUInt
derive newtype instance showTestUInt :: Show TestUInt
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
  checkMulIsPrecise
  mulRegression1

checkMulIsPrecise :: Effect Unit
checkMulIsPrecise = do
  let onlyLowBits :: TestUInt -> TestUInt
      onlyLowBits = over TestUInt $ and $ fromInt 0x1
  quickCheck \lhs rhs ->
    onlyLowBits (lhs * rhs) === onlyLowBits lhs * onlyLowBits rhs

mulRegression1 :: Effect Unit
mulRegression1 = do
  let lhs = fromInt (-2047875787)
      rhs = fromInt (-1028477387)
      expected = fromInt 1364097529
  quickCheck $ lhs * rhs === expected

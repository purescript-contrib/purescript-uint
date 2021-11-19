module Data.UInt.Gen where

import Prelude ((<$>))
import Data.UInt (UInt, fromNumber, toNumber)
import Control.Monad.Gen.Class (class MonadGen, chooseFloat)

genUInt :: forall m. MonadGen m => UInt -> UInt -> m UInt
genUInt a b = fromNumber <$> chooseFloat (toNumber a) (toNumber b)


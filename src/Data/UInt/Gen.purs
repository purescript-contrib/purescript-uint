module Data.UInt.Gen where

import Prelude ((<$>), negate)
import Data.UInt (UInt, fromNumber)
import Control.Monad.Gen.Class (class MonadGen, chooseFloat)


genUInt :: forall m. MonadGen m => m UInt
genUInt = fromNumber <$> chooseFloat (-9007199254740991.0) 9007199254740991.0

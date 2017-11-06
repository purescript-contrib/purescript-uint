module Data.UInt.Gen where

import Control.Monad.Gen (class MonadGen, chooseInt)
import Data.Bounded (bottom, top)
import Data.Functor ((<$>))
import Data.UInt (UInt, fromInt)

-- | Generates a random `UInt`.
genUInt :: forall m. MonadGen m => m UInt
genUInt = fromInt <$> chooseInt bottom top

import Control.Monad.Missiles (MonadWarfare(..)) where

import Data.Proxy

-- | Implement this class to allow national or international warfare.
class MonadWarfare m where
    launchMissiles :: m ()

instance MonadWarfare (Proxy war) where
    launchMissiles = Proxy
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Supply
    (
      Supply
    , next
    , runSupply
    ) where

import Control.Monad.State
import Debug.Trace

newtype Supply s a = S (State [s] a) deriving (Monad)

-- unwrapS :: Supply s a -> State [s] a
-- unwrapS (S s) = s

runSupply :: Supply s a -> [s] -> (a, [s])
runSupply (S m) = runState m

next :: Supply s (Maybe s)
next = S $ do st <- get
              case st of
                [] -> return Nothing
                (x:xs) -> do put xs
                             return (Just x)

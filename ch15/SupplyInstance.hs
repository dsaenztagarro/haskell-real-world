{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleInstances,
             MultiParamTypeClasses #-}

import SupplyClass
import System.Random hiding (next)

newtype Reader e a = R { runReader :: e -> a }

instance Monad (Reader e) where
    return a = R $ \_ -> a
    m >>= k = R $ \r -> runReader (k (runReader m r)) r

ask :: Reader e e
ask = R id

newtype MySupply e a = MySupply { runMySupply :: Reader e a } deriving (Monad)

instance MonadSupply e (MySupply e) where
    next = MySupply $ do
             v <- ask
             return (Just v)

xy :: (Num s, MonadSupply s m) => m s
xy = do
    Just x <- next
    Just y <- next
    return (x * y)

randomsIO :: Random a => IO [a]
randomsIO =
    getStdRandom $ \g ->
        let (a, b) = split g
        in (randoms a, b)

runMS :: MySupply i a -> i -> a
runMS = runReader . runMySupply

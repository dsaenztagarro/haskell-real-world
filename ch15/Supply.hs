module Supply
    (
      Supply
    , next
    , runSupply
    ) where

runSupply :: Supply s a -> [s] -> (a, [s])

next :: Supply s (Maybe s)

module Random where

import System.Random
import Control.Monad.State

rand :: IO Int
rand = getStdRandom (randomR (0, maxBound))

twoBadRandoms :: RandomGen g => g -> (Int, Int)
twoBadRandoms gen = (fst $ random gen, fst $ random gen)

twoGoodRandoms :: RandomGen g => g -> ((Int, Int), g)
twoGoodRandoms gen = let (a, gen') = random gen
                         (b, gen'') = random gen'
                     in ((a, b), gen'')

type RandomState a = State StdGen a

getRandom :: Random a => RandomState a
getRandom =
  get >>= \gen ->
  let (val, gen') = random gen in
  put gen' >>
  return val

getTwoRandoms :: Random a => RandomState(a, a)
getTwoRandoms = liftM2 (,) getRandom getRandom

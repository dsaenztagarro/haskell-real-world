import Data.Char (digitToInt, isNumber)

addEven :: [Int] -> Int -> [Int]
addEven list number = if even number
                      then list ++ [number]
                      else list

filterEven :: [Int] -> [Int]
filterEven list = foldl addEven [] list

-- filterEven [1,2,3,4] # => [2,4]

addEven' :: Int -> [Int] -> [Int]
addEven' number list = if even number
                       then list ++ [number]
                       else list

filterEven' :: [Int] -> [Int]
filterEven' list = foldr addEven' [] list

-- filterEven' [1,2,3,4] # => [4,2]

asIntList :: String -> [Int]
asIntList str = map digitToInt $ takeWhile maybeNumber str
   where maybeNumber x = if isNumber x
                         then True
                         else error $ "non-digit: " ++ [x]

acumulateInt acum digit = acum * 10 + digit

asInt_fold :: String -> Int
asInt_fold str
    | str == "" = 0
    | str == "-" = 0
    | head str == '-' = -1 * (asInt $ tail str)
    | otherwise = asInt str
  where asInt str = foldl acumulateInt 0 $ asIntList str


-- asInt_fold ""        # => 0
-- asInt_fold "-"       # => 0
-- asInt_fold "1798"    # => 1798
-- asInt_fold "-31337"  # => -31337
-- asInt_fold "25sdf34" # => *** Exception: non-digit: s

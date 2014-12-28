import Data.Char (digitToInt, isNumber)

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

concat :: [[a]] -> [a]
concat list = foldr acum [] list
    where acum nested_list list = nested_list ++ list

-- Main.concat [['a', 'b'], ['c', 'd']]    # => "abcd"
-- Prelude.concat [['a', 'b'], ['c', 'd']] # => "abcd"

takeWhile' condition (x:xs) = if condition x
                           then [x] ++ (takeWhile' condition xs)
                           else []
takeWhile' _ [] = []

-- takeWhile' isNumber "12sd" # => "12"


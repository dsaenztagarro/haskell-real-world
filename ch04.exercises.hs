import Data.Char (digitToInt, isNumber)
import Data.List (groupBy)

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
concat xs = foldr step [] xs
    where step x ys = x ++ ys

-- Main.concat [['a', 'b'], ['c', 'd']]    # => "abcd"
-- Prelude.concat [['a', 'b'], ['c', 'd']] # => "abcd"

takeWhile' condition (x:xs) = if condition x
                              then [x] ++ (takeWhile' condition xs)
                              else []
takeWhile' _ [] = []

-- explicit recursion
-- takeWhile' isNumber "12sd" # => "12"

takeWhile'' condition xs = foldr acum [] xs
    where acum x ys = if isNumber x then x:ys else []

-- using foldr

numberAndLetter x y = (isNumber) x && not (isNumber y)

groupBy' condition xs = result $ foldl step ([], []) xs
    where step (ys, zs) x = if length zs == 0 || condition (head zs) x
                            then (ys, zs ++ [x])
                            else (ys ++ [zs], [x])
          result (ys, zs) = ys ++ [zs]

-- groupBy' numberAndLetter "1aa33z" # => ["1aa","3","3z"]
-- groupBy' numberAndLetter "1aa2bb" # => ["1aa","2bb","3cc"]

any' check xs = foldl step False xs
    where step result x = if result then result else check x

-- any' isNumber "abc" # => False
-- any' isNumber "a1bc" # => True

cycle' xs = foldr step [] [1..]
    where step x ys = xs ++ ys

-- take 8 $ cycle "abc" # => "abcabcab"

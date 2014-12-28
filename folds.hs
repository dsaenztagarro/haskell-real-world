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

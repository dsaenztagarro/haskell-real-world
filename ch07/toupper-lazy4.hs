import System.IO
import Data.Char(toUpper)

-- runghc toupper-lazy4.hs < input.txt > output.txt
-- runghc toupper-lazy4.hs < input.txt

main :: IO ()
main = interact (map toUpper)

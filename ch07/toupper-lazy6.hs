import System.IO
import Data.Char(toUpper)

main = interact ((++) "Your data, in uppercase, is:\n\n" . map toUpper)


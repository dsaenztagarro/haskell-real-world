module Parse
  (
    parse
  , Parse(..)
  ) where

import Data.Int (Int64)

import qualified Data.ByteString.Lazy as L

data ParseState = ParseState
    { string :: L.ByteString
    , offset :: Int64
    } deriving (Show)

simpleParse :: ParseState -> Either String (a, ParseState)
simpleParse = undefined

newtype Parse a = Parse
    { runParse :: ParseState -> Either String (a, ParseState)
    }

identity :: a -> Parse a
identity a = Parse (\s -> Right (a, s))

parse :: Parse a -> L.ByteString -> Either String a
parse parser initState =
    case runParse parser (ParseState initState 0) of
         Left err -> Left err
         Right (result, _) -> Right result

import Data.Int (Int64)

data ParseState = ParseState
    { string :: L.ByteString
    , offset :: Int64
    } deriving (Show)

simpleParse :: ParseState -> Either String (a, ParseState)
simpleParse = undefined

newtype Parse a = Parse {
      runParse :: ParseState -> Either String (a, ParseState)
    }

module Main where

import Control.Monad

data MovieReview = MovieReview
    { revTitle :: String
    , revUser :: String
    , revReview :: String
    } deriving (Show)

maybeReview alist = do
    title <- lookup1 "title" alist
    user <- lookup1 "user" alist
    review <- lookup1 "review" alist
    return (MovieReview title user review)

lookup1 key alist = case lookup key alist of
                        Just (Just s@(_:_)) -> Just s
                        _ -> Nothing

liftedReview alist =
    liftM3 MovieReview (lookup1 "title" alist)
                       (lookup1 "user" alist)
                       (lookup1 "review" alist)

apReview alist =
    MovieReview `liftM` lookup1 "title" alist
                    `ap` lookup1 "user" alist
                    `ap` lookup1 "review" alist

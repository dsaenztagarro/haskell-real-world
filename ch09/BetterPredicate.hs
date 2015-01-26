{-# LANGUAGE ScopedTypeVariables #-}

import Control.Monad (filterM)
import System.Directory (Permissions(..), getModificationTime, getPermissions)
-- import System.Time
import Data.Time.Clock
import System.FilePath (takeExtension)
import Control.Exception (bracket, handle, IOException)
import System.IO (IOMode(..), hClose, hFileSize, openFile)

-- the function we wrote earlier
import RecursiveContents (getRecursiveContents)

type Predicate = FilePath      -- path to directory entry
              -> Permissions   -- permissions
              -> Maybe Integer -- file size (Nothing if not file)
              -> UTCTime     -- last modified
              -> Bool

getFileSize :: FilePath -> IO (Maybe Integer)

betterFind :: Predicate -> FilePath -> IO [FilePath]

betterFind p path = getRecursiveContents path >>= filterM check
    where check name = do
            perms <- getPermissions name
            size <- getFileSize name
            modified <- getModificationTime name
            return (p name perms size modified)

simpleFileSize :: FilePath -> IO Integer

simpleFileSize path = do
    h <- openFile path ReadMode
    size <- hFileSize h
    hClose h
    return size

saferFileSize :: FilePath -> IO (Maybe Integer)

saferFileSize path = handle (\(_ :: IOException) -> return Nothing) $ do
    h <- openFile path ReadMode
    size <- hFileSize h
    hClose h
    return (Just size)

getFileSize path = handle (\(_ :: IOException) -> return Nothing) $
    bracket (openFile path ReadMode) hClose $ \h -> do
      size <- hFileSize h
      return (Just size)

myTest path _ (Just size) _ =
    takeExtension path == ".cpp" && size > 131072
myTest _ _ _ _ = False

type InfoP a = FilePath      -- path to directory entry
            -> Permissions   -- permissions
            -> Maybe Integer -- file size (Nothing if not file)
            -> UTCTime       -- last modified
            -> a

pathP :: InfoP FilePath
pathP path _ _ _ = path

sizeP :: InfoP Integer
sizeP _ _ (Just size) _ = size
sizeP _ _ Nothing _     = -1

equalP :: (Eq a) => InfoP a -> a -> InfoP Bool
equalP f k = \w x y z -> f w x y z  == k

equalP' :: (Eq a) => InfoP a -> a -> InfoP Bool
equalP' f k w x y z = f w x y z == k

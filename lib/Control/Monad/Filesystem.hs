{-# LANGUAGE LinearTypes #-}

module Control.Monad.Filesystem (MonadFile(..), FileType(..)) where

import Data.ByteString.Char8      qualified as BSS
import Data.ByteString.Lazy.Char8 qualified as BSL
-- import System.File.OsPath
import System.IO
import System.OsPath.Types

data FileType = Text | Binary

{-}
class MonadHandle m where
    Handle
-}

class MonadFile m where
    openFile :: FileType → OsPath → m Handle
    withFile :: OsPath → IOMode → (Handle → m a) → m a
    readFile :: OsPath → m BSL.ByteString
    readFile' :: OsPath → m BSS.ByteString
    closeFile :: Handle %1-> m ()

class MonadWriteFile m where
    writeFileM :: OsPath → BSS.ByteString → m ()

class MonadReadFile m where
    readFileM :: OsPath → m BSL.ByteString

class MonadDirectory m where
    createDirectoryM :: OsPath → m ()
    removeDirectoryM :: OsPath → m ()
    removeDirectoryRecursiveM :: OsPath → m ()

{-}
class MonadDisk m where
    createPartition ::
-}

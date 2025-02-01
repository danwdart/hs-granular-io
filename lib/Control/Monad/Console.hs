module Control.Monad.Console () where

import Data.ByteString.Char8 (ByteString)
import Data.ByteString.Char8 qualified as B

class MonadWriteFD m where
    write :: Fd → ByteString → m ()
    writeLine :: Fd → ByteString → m ()

class MonadWriteConsole m where
    writeConsole :: s → m ()
    writeConsoleLine :: s → m ()

class MonadReadFD m where
    readChar :: FD → m ByteString
    readLine :: FD → m ByteString
    readContent :: FD → m ByteString

class MonadReadConsole m where
    readCharConsole :: FD → m ByteString
    readLineConsole :: FD → m ByteString
    readContentConsole :: FD → m ByteString

class MonadRWFD m where
    readChar :: FD → m ByteString
    readLine :: FD → m ByteString
    readContent :: FD → m ByteString
    write :: Fd → ByteString → m ()
    writeLine :: Fd → ByteString → m ()

class MonadRWConsole m where
    readCharConsole :: FD → m ByteString
    readLineConsole :: FD → m ByteString
    readContentConsole :: FD → m ByteString
    writeConsole :: s → m ()
    writeConsoleLine :: s → m ()

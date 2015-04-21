module Paths_BlogPost (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/eci/.cabal/bin"
libdir     = "/home/eci/.cabal/lib/x86_64-linux-ghc-7.8.3/BlogPost-0.0.0"
datadir    = "/home/eci/.cabal/share/x86_64-linux-ghc-7.8.3/BlogPost-0.0.0"
libexecdir = "/home/eci/.cabal/libexec"
sysconfdir = "/home/eci/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "BlogPost_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "BlogPost_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "BlogPost_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "BlogPost_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "BlogPost_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)

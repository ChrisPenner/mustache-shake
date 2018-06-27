{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.Text as T
import Development.Shake
import Development.Shake.FilePath
import Text.Mustache
import Text.Mustache.Shake

main :: IO ()
main =
  shakeArgs shakeOptions $ do
    want ["dist/index.html"]
    "dist/*.html" %> \htmlFile -> do
      templ <- compileTemplate' ("templates" </> dropDirectory1 htmlFile)
      let res =
            substitute
              templ
              (object [("title", toMustache ("Welcome!" :: String))])
      writeFile' htmlFile (T.unpack res)

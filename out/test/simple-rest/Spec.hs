{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Lib (app)
import Test.Hspec
import Test.Hspec.Wai
import Test.Hspec.Wai.JSON

main :: IO ()
main = hspec spec

spec :: Spec
spec = with (return app) $ do
    describe "GET /ping" $ do
        it "responds with 200" $ do
            get "/ping" `shouldRespondWith` 200
        it "responds with [pong]" $ do
            get "/ping" `shouldRespondWith` "pong"

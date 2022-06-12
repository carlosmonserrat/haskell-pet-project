{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Routing (startApp, app) where

import Handlers
import Network.Wai (Application)
import Network.Wai.Handler.Warp (run)
import Servant (Capture, Get, JSON, PlainText, Post, Proxy (..), ReqBody, Server, serve, (:<|>) (..), (:>))

type ROUTE =
  "ping" :> Get '[PlainText] String
    :<|> "book" :> Capture "id" Int :> Get '[JSON] Book
    :<|> "book" :> ReqBody '[JSON] Book :> Capture "id" Int :> Post '[JSON] String

startApp :: IO ()
startApp = run 8081 app

app :: Application
app = serve (Proxy :: Proxy ROUTE) server

server :: Server ROUTE
server = handlePing :<|> handleBook :<|> handleStoreBook

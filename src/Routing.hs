{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Routing (startApp, app) where

import Handlers
import Network.Wai (Application)
import Network.Wai.Handler.Warp (run)
import Servant
  ( Get,
    JSON,
    PlainText,
    Post,
    Proxy (..),
    Server,
    serve,
    Capture,
    (:<|>) (..),
    (:>),
  )

type ROUTE =
  "ping" :> Get '[PlainText] String
    :<|> "book" :> Capture "id" Int :> Get '[JSON] Book
    :<|> "book" :> Post '[JSON] String

startApp :: IO ()
startApp = run 8081 app

app :: Application
app = serve (Proxy :: Proxy ROUTE) server

server :: Server ROUTE
server = handlePing :<|> handleBook  :<|> handleStoreBook

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
    Proxy (..),
    Server,
    serve,
    (:<|>) (..),
    (:>),
  )

type ROUTE =
  "users" :> Get '[JSON] [User]
    :<|> "ping" :> Get '[PlainText] String

startApp :: IO ()
startApp = run 8081 app

app :: Application
app = serve (Proxy :: Proxy ROUTE) server
  
server :: Server ROUTE
server = handleUsers :<|> handlePing

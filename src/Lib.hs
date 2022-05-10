{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Lib (startApp, app) where

import Data.Aeson (defaultOptions)
import Data.Aeson.TH (deriveJSON)
import Network.Wai (Application)
import Network.Wai.Handler.Warp (run)
import Servant
  ( Get,
    Handler,
    JSON,
    PlainText,
    Proxy (..),
    Server,
    serve,
    (:<|>) (..),
    type (:<|>),
    type (:>),
  )

data User = User
  { userId :: Int,
    userFirstName :: String,
    userLastName :: String
  }
  deriving (Eq, Show)

$(deriveJSON defaultOptions ''User)

type API = "users" :> Get '[JSON] [User] :<|> "ping" :> Get '[PlainText] String

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve (Proxy :: Proxy API) server

handleUsers :: Handler [User]
handleUsers = return [User 1 "Carlos" "Rojas", User 2 "Marina" "Alekseeva"]

handlePing :: Handler String
handlePing = return "pong"

server :: Server API
server = handleUsers :<|> handlePing

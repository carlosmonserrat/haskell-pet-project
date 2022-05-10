{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Lib
  ( startApp,
    app,
  )
where

import Data.Aeson (defaultOptions)
import Data.Aeson.TH (deriveJSON)
import Network.Wai (Application)
import Network.Wai.Handler.Warp (run)
import Servant (Get, JSON, Proxy (..), Server, serve, type (:>))

data User = User
  { userId :: Int,
    userFirstName :: String,
    userLastName :: String
  }
  deriving (Eq, Show)

$(deriveJSON defaultOptions ''User)

type API = "users" :> Get '[JSON] [User]

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = return users

users :: [User]
users = [User 1 "Carlos" "Rojayas", User 2 "Marina" "Alekseeva"]

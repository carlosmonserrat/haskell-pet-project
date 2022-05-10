{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Handlers (handleUsers, handlePing, User) where

import Data.Aeson (defaultOptions)
import Data.Aeson.TH (deriveJSON)
import Servant (Handler)

data User = User
  { userId :: Int,
    userFirstName :: String,
    userLastName :: String
  }
  deriving (Eq, Show)

$(deriveJSON defaultOptions ''User)

handleUsers :: Handler [User]
handleUsers = return [User 1 "Carlos" "Rojas", User 2 "Marina" "Alekseeva"]

handlePing :: Handler String
handlePing = return "pong"

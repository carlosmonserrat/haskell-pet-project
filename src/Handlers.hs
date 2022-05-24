{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Handlers (handleBook, handlePing, handleStoreBook, Book) where

import Data.Aeson (defaultOptions)
import Data.Aeson.TH (deriveJSON)
import Servant (Handler)

data Book = Book
  { userId :: Int,
    bookName :: String,
    bookAuthor :: String
  }
  deriving (Eq, Show)

$(deriveJSON defaultOptions ''Book)

handleStoreBook :: Handler String
handleStoreBook = return "stored"

handleBook :: Int -> Handler Book
handleBook bookId = return (Book bookId "The secrets of the sea" "Charles Dickens")

handlePing :: Handler String
handlePing = do
  return "pong"

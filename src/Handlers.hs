{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Handlers (handleBook, handlePing, handleStoreBook, Book) where

import Database
import Control.Monad.IO.Class (liftIO)
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

handleStoreBook :: Book -> Int -> Handler String
handleStoreBook book bookId = do
  liftIO $ addNewBook
  return $ "stored " ++ show (bookId) ++ show (book)

handleBook :: Int -> Handler Book
handleBook bookId = return (Book bookId "The secrets of the sea" "Charles Dickens")

handlePing :: Handler String
handlePing = do
  return "pong"

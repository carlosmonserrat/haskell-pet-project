{-# LANGUAGE OverloadedStrings #-}

module Database (simpleQuery, addNewBook) where

import Database.PostgreSQL.Simple

localPG :: ConnectInfo
localPG = defaultConnectInfo {connectPort = 5432, connectHost = "localhost", connectDatabase = "books", connectUser = "test", connectPassword = "test"}

simpleQuery :: IO ()
simpleQuery = do
  conn <- connect localPG
  mapM_ print =<< (query_ conn "SELECT 1 + 1" :: IO [Only Int])

addNewBook :: IO ()
addNewBook = do
  conn <- connect localPG
  let query = "INSERT INTO books (id, book) VALUES (?,?)"
  let parameters = ["aadswwdasdw" :: String, "some book" :: String]
  res <- execute conn query parameters
  print res

module Data.Task
  ( Task
  , new
  ) where

import Prelude

import Data.UUID (UUID)
import Data.UUID as UUID
import Effect (Effect)

type Task =
  { uuid :: UUID
  , description :: String
  , completed :: Boolean
  }

new :: String -> Effect Task
new description = do
  uuid <- UUID.new
  pure
    { uuid
    , description
    , completed: false
    }

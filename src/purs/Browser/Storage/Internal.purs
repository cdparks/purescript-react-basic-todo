module Browser.Storage.Internal
  ( getItem
  , setItem
  , removeItem
  , getItemImpl
  , setItemImpl
  ) where

import Prelude

import Data.Either (hush)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Simple.JSON (readJSON, writeJSON, class ReadForeign, class WriteForeign)

getItem :: forall a. ReadForeign a => String -> Effect (Maybe a)
getItem = getItemImpl Nothing (hush <<< readJSON)

setItem :: forall a. WriteForeign a => String -> a -> Effect Unit
setItem key = setItemImpl key <<< writeJSON

foreign import getItemImpl
  :: forall a
   . Maybe a
  -> (String -> Maybe a)
  -> String
  -> Effect (Maybe a)

foreign import setItemImpl
  :: String
  -> String
  -> Effect Unit

foreign import removeItem
  :: String
  -> Effect Unit

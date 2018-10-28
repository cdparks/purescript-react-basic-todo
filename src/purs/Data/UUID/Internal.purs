module Data.UUID.Internal
  ( UUID(..)
  , new
  , parse
  , toString
  , newImpl
  , parseImpl
  ) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Eq (genericEq)
import Data.Generic.Rep.Ord (genericCompare)
import Data.Generic.Rep.Show (genericShow)
import Effect (Effect)
import Foreign (ForeignError(..), fail)
import Simple.JSON (class ReadForeign, readImpl, class WriteForeign, writeImpl)

newtype UUID = UUID String

derive instance genericUUID :: Generic UUID _

instance eqUUID :: Eq UUID where
  eq = genericEq

instance ordUUID :: Ord UUID where
  compare = genericCompare

instance showUUID :: Show UUID where
  show = genericShow

instance readUUID :: ReadForeign UUID where
  readImpl str = do
    raw <- readImpl str
    case parse raw of
      Nothing ->
        fail $ ForeignError $ "Not a UUID V4 " <> raw
      Just uuid ->
        pure uuid

instance writeUUID :: WriteForeign UUID where
  writeImpl = writeImpl <<< toString

new :: Effect UUID
new = newImpl UUID

parse :: String -> Maybe UUID
parse = parseImpl Nothing (Just <<< UUID)

toString :: UUID -> String
toString (UUID uuid) = uuid

foreign import newImpl
  :: (String -> UUID)
  -> Effect UUID

foreign import parseImpl
  :: Maybe UUID
  -> (String -> Maybe UUID)
  -> String
  -> Maybe UUID

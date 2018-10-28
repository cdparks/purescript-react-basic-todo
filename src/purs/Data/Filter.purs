module Data.Filter
  ( Filter(..)
  ) where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Eq (genericEq)
import Data.Generic.Rep.Ord (genericCompare)
import Data.Generic.Rep.Show (genericShow)

data Filter
  = All
  | Active
  | Completed

derive instance genericFilter :: Generic Filter _

instance showFilter :: Show Filter where
  show = genericShow

instance eqFilter :: Eq Filter where
  eq = genericEq

instance ordFilter :: Ord Filter where
  compare = genericCompare

module Main
  ( main
  ) where

import Prelude

import Browser.Storage as Storage
import Components.App as App
import Data.Array as Array
import Data.Maybe (fromMaybe)
import Effect (Effect)
import Effect.Console as Console
import React.Render (renderTo)

main :: Effect Unit
main = do
  tasks <- fromMaybe [] <$> Storage.getItem "tasks"
  Console.log $ summarize tasks
  renderTo "root" App.component {initialTasks: tasks}

summarize :: forall fields. Array { completed :: Boolean | fields } -> String
summarize tasks =
  show numCompleted <> "/" <> show numTotal <> " completed"
 where
  numTotal = Array.length tasks
  numCompleted = Array.length $ Array.filter _.completed tasks

module Main
  ( main
  ) where

import Prelude

import Browser.Storage as Storage
import Data.Maybe (fromMaybe)
import Effect (Effect)
import React.Render (renderTo)

import Components.App as App

main :: Effect Unit
main = do
  tasks <- fromMaybe [] <$> Storage.getItem "tasks"
  renderTo "root" App.component {initialTasks: tasks}

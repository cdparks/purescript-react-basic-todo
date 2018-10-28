module Main
  ( main
  ) where

import Prelude

import Effect (Effect)
import React.Render (renderTo)
import Data.Maybe (fromMaybe)
import Browser.Storage (getItem)

import Components.App as App

main :: Effect Unit
main = do
  tasks <- fromMaybe [] <$> getItem "tasks"
  renderTo "root" App.component {initialTasks: tasks}

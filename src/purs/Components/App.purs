module Components.App
  ( component
  ) where

import Prelude

import Browser.Storage as Storage
import Components.Header as Header
import Components.Input as Input
import Components.Tasks as Tasks
import Components.Filters as Filters
import Data.Array (filter, snoc)
import Data.Filter (Filter(..))
import Data.Task (Task)
import Data.UUID (UUID)
import Effect (Effect)
import React.Basic as React
import React.Basic.DOM as R

type Props =
  { initialTasks :: Array Task
  }

type State =
  { tasks :: Array Task
  , filter :: Filter
  }

component :: React.Component Props
component =
  React.component {displayName: "App", initialState, receiveProps, render}
 where
  initialState =
    { tasks: []
    , filter: All
    }

  receiveProps {isFirstMount, props, setState} =
    when isFirstMount
      $ setState
      $ _ { tasks = props.initialTasks }

  render {state, setState, setStateThen} =
    R.section
     { className: "section"
     , children:
       [ R.div
         { className: "container"
         , children:
           [ React.element Header.component {}
           , React.element Input.component
             { onSubmit: \task -> addTask task `setStateThen` save
             }
           , React.element Tasks.component
             { tasks: state.tasks
             , onClear: \uuid -> clearTask uuid `setStateThen` save
             , onComplete: \uuid -> completeTask uuid `setStateThen` save
             }
           , React.element Filters.component
             { filter: state.filter
             , onSetFilter: setState <<< setFilter
             }
           ]
         }
       ]
     }

addTask :: Task -> State -> State
addTask task s = s { tasks = s.tasks `snoc` task }

clearTask :: UUID -> State -> State
clearTask uuid s = s { tasks = filter isOtherTask s.tasks }
 where
  isOtherTask t = t.uuid /= uuid

completeTask :: UUID -> State -> State
completeTask uuid s = s { tasks = map completeMatch s.tasks }
 where
  completeMatch t
    | t.uuid == uuid = t { completed = true }
    | otherwise = t

setFilter :: Filter -> State -> State
setFilter filter' = _ { filter = filter' }

save :: State -> Effect Unit
save s = Storage.setItem "tasks" s.tasks

filterBy :: Filter -> Array Task -> Array Task
filterBy All tasks = tasks
filterBy Active tasks = filter (not <<< _.completed) tasks
filterBy Completed tasks = filter _.completed tasks

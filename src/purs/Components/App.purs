module Components.App
  ( component
  ) where

import Prelude

import Browser.Storage as Storage
import Components.Clear as Clear
import Components.Filters as Filters
import Components.Header as Header
import Components.Input as Input
import Components.Tasks as Tasks
import Data.Array (any, filter, snoc)
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
    panel
      [ React.element Header.component {}
      , React.element Input.component
        { onSubmit: addTask >>> (_ `setStateThen` save)
        }
      , React.element Filters.component
        { filter: state.filter
        , onSetFilter: setFilter >>> setState
        }
      , React.element Tasks.component
        { tasks: filterBy state.filter state.tasks
        , onDelete: deleteTask >>> (_ `setStateThen` save)
        , onToggle: toggleTask >>> (_ `setStateThen` save)
        }
      , renderIf (any _.completed state.tasks)
        $ React.element Clear.component
          { onClear: deleteCompleted `setStateThen` save
          }
      ]

panel :: Array React.JSX -> React.JSX
panel elements =
  R.section
    { className: "section"
    , children:
      [ R.nav
        { className: "panel"
        , children: elements
        }
      ]
    }

renderIf :: Boolean -> React.JSX -> React.JSX
renderIf cond element
  | cond = element
  | otherwise = React.empty

addTask :: Task -> State -> State
addTask task s = s { tasks = s.tasks `snoc` task }

deleteTask :: UUID -> State -> State
deleteTask uuid s = s { tasks = filter isOtherTask s.tasks }
 where
  isOtherTask t = t.uuid /= uuid

deleteCompleted :: State -> State
deleteCompleted s = s { tasks = filter (not <<< _.completed) s.tasks }

toggleTask :: UUID -> State -> State
toggleTask uuid s = s { tasks = map toggleMatch s.tasks }
 where
  toggleMatch t
    | t.uuid == uuid = t { completed = not $ t.completed }
    | otherwise = t

setFilter :: Filter -> State -> State
setFilter filter' = _ { filter = filter' }

save :: State -> Effect Unit
save s = Storage.setItem "tasks" s.tasks

filterBy :: Filter -> Array Task -> Array Task
filterBy All tasks = tasks
filterBy Active tasks = filter (not <<< _.completed) tasks
filterBy Completed tasks = filter _.completed tasks

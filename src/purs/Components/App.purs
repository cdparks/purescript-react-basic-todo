module Components.App
  ( component
  ) where

import Prelude

import React.Basic as React
import React.Basic.DOM as R

import Data.Task (Task)
import Data.Filter (Filter(..))

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

  render {state} =
    R.section
     { className: "section"
     , children:
       [ R.div
         { className: "container"
         , children:
           [ R.h1
             { className: "title"
             , children: [R.text "Todos"]
             }
           ]
         }
       ]
     }

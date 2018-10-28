module Components.Tasks
  ( component
  ) where

import Prelude

import Data.Task (Task)
import Data.UUID (UUID)
import Effect (Effect)
import React.Basic as React
import React.Basic.DOM as R

type Props =
  { tasks :: Array Task
  , onClear :: UUID -> Effect Unit
  , onComplete :: UUID -> Effect Unit
  }

component :: React.Component Props
component =
  React.stateless {displayName: "Tasks", render}
 where
  render _ =
    R.h1
      { className: "title"
      , children: [R.text "Tasks"]
      }

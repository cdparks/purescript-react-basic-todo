module Components.Input
  ( component
  ) where

import Prelude

import Data.Task (Task)
import Effect (Effect)
import React.Basic as React
import React.Basic.DOM as R

type Props =
  { onSubmit :: Task -> Effect Unit
  }

component :: React.Component Props
component =
  React.stateless {displayName: "Input", render}
 where
  render _ =
    R.h1
      { className: "title"
      , children: [R.text "Input"]
      }

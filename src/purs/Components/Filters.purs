module Components.Filters
  ( component
  ) where

import Prelude

import Data.Filter (Filter)
import Effect (Effect)
import React.Basic as React
import React.Basic.DOM as R

type Props =
  { filter :: Filter
  , onSetFilter :: Filter -> Effect Unit
  }

component :: React.Component Props
component =
  React.stateless {displayName: "Filters", render}
 where
  render _ =
    R.h1
      { className: "title"
      , children: [R.text "Filters"]
      }

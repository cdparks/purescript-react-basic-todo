module Components.Header
  ( component
  ) where

import React.Basic as React
import React.Basic.DOM as R

component :: React.Component {}
component =
  React.stateless {displayName: "Header", render}
 where
  render _ =
    R.p
      { className: "panel-heading has-text-centered"
      , children: [R.text "Todos"]
      }

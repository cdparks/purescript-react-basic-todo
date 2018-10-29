module Components.Clear
  ( component
  ) where

import Prelude

import Effect (Effect)
import React.Basic as React
import React.Basic.DOM as R
import React.Basic.Events as Events

type Props =
  { onClear :: Effect Unit
  }

component :: React.Component Props
component = React.stateless {displayName: "Clear", render}

render :: Props -> React.JSX
render {onClear} =
  R.div
    { className: "panel-block"
    , children:
      [ R.button
        { onClick: Events.handler_ onClear
        , className: "button is-danger is-link is-outlined is-fullwidth"
        , children: [R.text "Clear completed tasks"]
        }
      ]
    }

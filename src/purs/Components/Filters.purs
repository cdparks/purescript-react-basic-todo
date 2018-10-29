module Components.Filters
  ( component
  ) where

import Prelude

import Data.Filter (Filter(..))
import Effect (Effect)
import React.Basic as React
import React.Basic.DOM as R
import React.Basic.DOM.Events (preventDefault)
import React.Basic.Events as Events

type Props =
  { filter :: Filter
  , onSetFilter :: Filter -> Effect Unit
  }

component :: React.Component Props
component = React.stateless {displayName: "Filters", render}

render :: Props -> React.JSX
render props =
  R.p
    { className: "panel-tabs"
    , children:
      [ filterTab All
      , filterTab Active
      , filterTab Completed
      ]
    }
 where
  filterTab :: Filter -> React.JSX
  filterTab filter
    | filter == props.filter = tab filter "is-active" $ pure unit
    | otherwise = tab filter "" $ props.onSetFilter filter

  tab :: Filter -> String -> Effect Unit -> React.JSX
  tab filter className onClick =
    R.a
      { href: "#"
      , role: "button"
      , className: className
      , onClick: Events.handler preventDefault $ const onClick
      , children: [R.text $ show filter]
      }

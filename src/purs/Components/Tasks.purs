module Components.Tasks
  ( component
  ) where

import Prelude

import Data.Foldable (foldMap)
import Data.Task (Task)
import Data.UUID (UUID)
import Data.UUID as UUID
import Effect (Effect)
import React.Basic as React
import React.Basic.DOM as R
import React.Basic.DOM.Events (preventDefault)
import React.Basic.Events as Events

type Props =
  { tasks :: Array Task
  , onDelete :: UUID -> Effect Unit
  , onToggle :: UUID -> Effect Unit
  }

component :: React.Component Props
component = React.stateless {displayName: "Tasks", render}

render :: Props -> React.JSX
render {tasks, onDelete, onToggle} =
  foldMap renderTask tasks
 where
  renderTask :: Task -> React.JSX
  renderTask task =
    React.fragmentKeyed
      (UUID.toString task.uuid)
      [ R.label
        { className: "panel-block"
        , children:
          [ checkBox task
          , R.span
            { className: "fullwidth"
            , children: [describe task]
            }
          , deleteButton task
          ]
        }
      ]

  checkBox :: Task -> React.JSX
  checkBox {uuid, completed} =
    R.input
      { "type": "checkbox"
      , checked: completed
      , onChange: Events.handler_ $ onToggle uuid
      }

  describe :: Task -> React.JSX
  describe {completed, description}
    | completed = R.s { children: [R.text description] }
    | otherwise = R.text description

  deleteButton :: Task -> React.JSX
  deleteButton {uuid} =
    R.a
      { role: "button"
      , href: "#"
      , className: "delete"
      , onClick: Events.handler preventDefault $ const $ onDelete uuid
      }

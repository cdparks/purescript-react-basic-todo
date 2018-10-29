module Components.Input
  ( component
  ) where

import Prelude

import Data.Foldable (traverse_)
import Data.Maybe (Maybe)
import Data.String (trim)
import Data.Task (Task)
import Data.Task as Task
import Effect (Effect)
import React.Basic as React
import React.Basic.DOM as R
import React.Basic.DOM.Events (targetValue, preventDefault)
import React.Basic.Events as Events

type Props =
  { onSubmit :: Task -> Effect Unit
  }

type State =
  { description :: String
  }

component :: React.Component Props
component =
  React.component {displayName: "Input", receiveProps, initialState, render}
 where
  receiveProps _ =
    pure unit

  initialState =
    { description: ""
    }

-- I'm not sure why purescript-react-basic doesn't
-- export this type
type SetState state = (state -> state) -> Effect Unit

render :: forall r. {props :: Props, state :: State, setState :: SetState State | r} -> React.JSX
render {props, state, setState} =
  R.div
    { className: "panel-block"
    , children:
      [ R.form
        { className: "control"
        , onSubmit: Events.handler preventDefault handleSubmit
        , children:
          [ R.input
            { className: "input"
            , "type": "text"
            , placeholder: "Add task here"
            , value: state.description
            , onChange: Events.handler targetValue handleChange
            }
          ]
        }
      ]
    }
 where
  handleSubmit :: forall e. e -> Effect Unit
  handleSubmit _ = do
    let trimmed = trim state.description
    when (trimmed /= "") do
      setState $ setDescription ""
      task <- Task.new trimmed
      props.onSubmit task

  handleChange :: Maybe String -> Effect Unit
  handleChange = traverse_ $ setState <<< setDescription

setDescription :: String -> State -> State
setDescription description = _ { description = description }

module Components.App
  ( component
  ) where

import React.Basic as React
import React.Basic.DOM as R

component :: React.Component {}
component =
  React.stateless {displayName: "App", render}
 where
   render _ =
     R.section
      { className: "section"
      , children:
        [ R.div
          { className: "container"
          , children:
            [ R.h1
              { className: "title"
              , children: [R.text "Hello World!"]
              }
            ]
          }
        ]
      }

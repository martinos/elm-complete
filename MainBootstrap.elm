module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    div []
        [ bootstrap
        , div [ class "dropdown show" ]
            [ button [ attribute "aria-expanded" "false", attribute "aria-haspopup" "true", class "btn btn-secondary dropdown-toggle", attribute "data-toggle" "dropdown", id "dropdownMenuButton", type_ "button" ]
                [ text "Dropdown button  " ]
            , div [ attribute "aria-labelledby" "dropdownMenuButton", class "dropdown-menu" ]
                [ a [ class "dropdown-item", href "#" ]
                    [ text "Action" ]
                , a [ class "dropdown-item", href "#" ]
                    [ text "Another action" ]
                , a [ class "dropdown-item", href "#" ]
                    [ text "Something else here" ]
                ]
            ]
        ]


css : String -> Html msg
css path =
    node "link" [ rel "stylesheet", href path ] []


bootstrap =
    css "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"

module BulmaView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onMouseOver, onMouseDown)
import Selector as S
import AutoComp as A


autoComplInput : (a -> String) -> String -> A.State a -> Html (A.Msg a)
autoComplInput toStr labelStr state =
    div [ class "dropdown", classList [ ( "is-active", S.showSelector state.selector ) ] ]
        [ div []
            [ label [ class "label" ] [ text labelStr ]
            , div [ class "control" ]
                [ input
                    ([ type_ "text", class "input" ]
                        ++ A.inputAttributes state
                    )
                    []
                ]
            , div [ class "dropdown-menu", id "dropdown-menu", attribute "role" "menu" ]
                [ div [ class "dropdown-content" ]
                    (state.selector
                        |> S.viewSelector (viewSelected toStr) (viewUnselected toStr)
                    )
                ]
                |> Html.map A.ToSelector
            ]
        ]


viewUnselected toStr ( idx, elem ) =
    a [ class "dropdown-item", onMouseOver (S.OnHover idx), onMouseDown (S.OnClick idx) ]
        [ toStr elem |> text ]


viewSelected : (a -> String) -> ( Int, a ) -> Html (S.Op a)
viewSelected toStr ( idx, elem ) =
    a [ class "dropdown-item is-active", onMouseOver (S.OnHover idx), onMouseDown (S.OnClick idx) ]
        [ toStr elem |> text ]

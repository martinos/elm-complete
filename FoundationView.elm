module FoundationView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onMouseOver, onMouseDown)
import Selector as S
import AutoComp as A


autoComplInput : (a -> Html (S.Op a)) -> String -> A.State a -> Html (A.Msg a)
autoComplInput toHtml labelStr state =
    div [ class "grid-container" ]
        [ div [ class "grid-x grid-padding-x" ]
            [ div [ class "cell" ]
                [ ul [ class "dropdown menu" ]
                    [ li [ class "is-dropdown-submenu-parent opens-right" ]
                        [ label [] [ text labelStr, input ([ type_ "text" ] ++ A.inputAttributes state) [] ]
                        , ul
                            [ class "menu submenu is-dropdown-submenu first-sub vertical", classList [ ( "js-dropdown-active", S.showSelector state.selector ) ] ]
                            (state.selector
                                |> S.viewSelector (viewSelected toHtml) (viewUnselected toHtml)
                            )
                            |> Html.map A.ToSelector
                        ]
                    ]
                ]
            ]
        ]


viewUnselected toHtml ( idx, elem ) =
    li
        [ class "is-submenu-item is-dropdown-submenu-item"
        , onMouseOver (S.OnHover idx)
        , onMouseDown (S.OnClick idx)
        ]
        [ a [] [ elem |> toHtml ] ]


viewSelected toHtml ( idx, elem ) =
    li
        [ class "is-submenu-item is-dropdown-submenu-item"
        , onMouseOver (S.OnHover idx)
        , onMouseDown (S.OnClick idx)
        , style [ ( "background-color", "#EEEEEE" ) ]
        ]
        [ a [] [ elem |> toHtml ] ]

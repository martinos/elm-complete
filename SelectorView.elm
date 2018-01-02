module SelectorView exposing (..)

import Html exposing (text, Html, li, ul, div, input, label)
import Html.Attributes exposing (style)
import Html.Events exposing (onMouseOver, onMouseDown)
import Selector as S


inputSelectionContainer =
    [ ( "display", "block" )
    , ( "position", "absolute" )
    , ( "margin-top", "0px" )
    , ( "z-index", "2" )
    , ( "background-color", "white" )
    , ( "border", "1px solid #aaa" )
    ]


ulMenuStyle =
    [ ( "list-style-type", "none" )
    , ( "margin", "0px" )
    , ( "padding", "0px" )
    ]


selectionStyle =
    [ ( "padding", "8px 15px" )
    , ( "display", "list-item" )
    ]


viewUnselected : (a -> String) -> ( Int, a ) -> Html (S.Op a)
viewUnselected toStr ( idx, elem ) =
    li
        [ style selectionStyle
        , onmouseover (s.onhover idx)
        , onmousedown (s.onclick idx)
        ]
        [ elem |> toStr |> text ]


withEvents idx attrs =
    attrs
        ++ [ onMouseOver (S.OnHover idx)
           , onMouseDown (S.OnClick idx)
           ]


viewSelected : (a -> String) -> ( Int, a ) -> Html (S.Op a)
viewSelected toStr ( idx, elem ) =
    li
        ([ style (( "background-color", "#EEEEEE" ) :: selectionStyle) ]
            |> withEvents idx
        )
        [ elem |> toStr |> text ]


selectorInput : String -> S.State a -> Html (S.Op a)
selectorInput labelText state =
    div []
        [ label [] [ text labelText ]
        , div []
            [ input (S.inputAttributes state) []
            , div [ style inputSelectionContainer ]
                [ ul [ style ulMenuStyle ]
                    (state.selector
                        |> S.viewSelector (viewSelected state.toString) (viewUnselected state.toString)
                    )
                ]
            ]
        ]

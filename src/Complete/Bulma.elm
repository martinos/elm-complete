module Complete.Bulma exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onMouseOver, onMouseDown)
import Complete.Selector as S
import Complete as A


autoComplInput : (a -> Html (S.Op a)) -> String -> A.State a -> Html (A.Msg a)
autoComplInput toHtml labelStr state =
    div [ class "field" ]
        [ div [ class "dropdown", classList [ ( "is-active", S.showSelector state.selector ) ] ]
            [ div []
                [ label [ class "label" ] [ text labelStr ]
                , div [ class "control" ]
                    [ input
                        ([ type_ "text", class "input" ] ++ A.inputAttributes state)
                        []
                    ]
                , div [ class "dropdown-menu", id "dropdown-menu", attribute "role" "menu" ]
                    [ div [ class "dropdown-content" ]
                        (state.selector
                            |> S.viewSelector (viewSelected toHtml) (viewUnselected toHtml)
                        )
                    ]
                    |> Html.map A.ToSelector
                ]
            ]
        ]


viewUnselected toHtml ( idx, elem ) =
    a [ class "dropdown-item", onMouseOver (S.OnHover idx), onMouseDown (S.OnClick idx) ]
        [ elem |> toHtml ]


viewSelected : (a -> Html (S.Op a)) -> ( Int, a ) -> Html (S.Op a)
viewSelected toHtml ( idx, elem ) =
    a [ class "dropdown-item is-active", onMouseOver (S.OnHover idx), onMouseDown (S.OnClick idx) ]
        [ elem |> toHtml ]

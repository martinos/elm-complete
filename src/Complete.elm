module Complete exposing (..)

import Complete.Selector as S exposing (Selector(..), Op(..), keyCodeTo, onKeyDown, filterList)
import Html exposing (Attribute)
import Html.Events exposing (onMouseOver, onMouseDown, onBlur, onInput)
import Html.Attributes exposing (attribute, value, type_)


type Msg a
    = SetInput String
    | ToSelector (Op a)


type alias State a =
    { input : String, selector : Selector a }


initState =
    { input = "", selector = NoneSelected [] }


update : (a -> String) -> List a -> Msg a -> State a -> State a
update toStr elems msg model =
    case msg of
        SetInput str ->
            { model
                | input = str
                , selector = elems |> List.filter (toStr >> filterList str) |> NoneSelected
            }

        ToSelector op ->
            let
                ( selector, selected ) =
                    model.selector |> S.update op
            in
                { model
                    | selector = selector
                    , input = selected |> Maybe.map toStr |> Maybe.withDefault model.input
                }


inputAttributes : State a -> List (Attribute (Msg a))
inputAttributes state =
    [ type_ "text"
    , value state.input
    , onInput SetInput
    , onKeyDown (keyCodeTo >> ToSelector)
    , onBlur (ToSelector Esc)
    ]

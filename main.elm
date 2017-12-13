module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Pivot as P
import Keyboard as K
import Json.Decode as JD
import Regex


type alias Model =
    { selector : Selector String, customers : List String, filterInput : String }


model : Model
model =
    { selector =
        NoneSelected []
    , filterInput = ""
    , customers = [ "teksavvy", "swifvox", "ccom", "caspian", "ispt" ]
    }


type Msg
    = KeyDown Key
    | FilterInput String


main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


update msg model =
    case msg of
        KeyDown key ->
            case key of
                Up ->
                    ( { model | selector = model.selector |> moveL }, Cmd.none )

                Down ->
                    ( { model | selector = model.selector |> moveR }, Cmd.none )

                Enter ->
                    let
                        input =
                            case model.selector of
                                Selected a ->
                                    a |> P.getC

                                NoneSelected _ ->
                                    model.filterInput
                    in
                        ( { model | filterInput = input, selector = emptySelector }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        FilterInput str ->
            ( { model
                | filterInput = str
                , selector = model.customers |> filterSelection str
              }
            , Cmd.none
            )


emptySelector =
    NoneSelected []


filterSelection str selector =
    if str |> String.isEmpty then
        emptySelector
    else
        selector |> List.filter (filterList str) |> NoneSelected


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput FilterInput, value model.filterInput, onKeyDown (keyCodeTo >> KeyDown) ] []
        , ul []
            (model.selector |> viewSelection)
        ]


viewSelection model =
    case model of
        Selected pivot ->
            pivot |> P.mapCLR viewSelected viewUnselected viewUnselected |> P.getA

        NoneSelected list ->
            list |> List.map viewUnselected


viewUnselected : String -> Html msg
viewUnselected elem =
    li []
        [ elem |> text ]


viewSelected : String -> Html msg
viewSelected elem =
    li [ style [ ( "background-color", "gray" ) ] ]
        [ b [] [ elem |> text ] ]


filterList =
    Regex.regex >> Regex.caseInsensitive >> Regex.contains


toList selector =
    case selector of
        Selected a ->
            a |> P.getA

        NoneSelected a ->
            a


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (JD.map tagger keyCode)


type Key
    = Up
    | Down
    | Enter
    | Other K.KeyCode


type Selector a
    = NoneSelected (List a)
    | Selected (P.Pivot a)


keyCodeTo code =
    case code of
        38 ->
            Up

        40 ->
            Down

        13 ->
            Enter

        _ ->
            Other code


moveL : Selector a -> Selector a
moveL selector =
    case selector of
        Selected pivot ->
            pivot |> P.goL |> Maybe.map Selected |> Maybe.withDefault (pivot |> P.getA |> NoneSelected)

        NoneSelected list ->
            list |> P.fromList |> Maybe.map (P.goToEnd >> Selected) |> Maybe.withDefault (NoneSelected list)


moveR : Selector a -> Selector a
moveR selector =
    case selector of
        Selected pivot ->
            pivot |> P.goR |> Maybe.map Selected |> Maybe.withDefault (pivot |> P.getA |> NoneSelected)

        NoneSelected list ->
            list |> P.fromList |> Maybe.map (P.goToStart >> Selected) |> Maybe.withDefault (NoneSelected list)

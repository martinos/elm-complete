module Selector exposing (..)

import Pivot as P
import Json.Decode as JD
import Html exposing (Attribute, Html)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Regex


type Op a
    = Up
    | Down
    | Enter
    | Esc
    | NoOp
    | OnHover Int
    | OnClick Int


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

        27 ->
            Esc

        -- ctrl-P
        80 ->
            Up

        -- ctrl-N
        78 ->
            Down

        _ ->
            NoOp


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


moveAt : Int -> Selector a -> Selector a
moveAt idx selector =
    case selector of
        Selected pivot ->
            pivot |> P.goTo idx |> Maybe.map Selected |> Maybe.withDefault (pivot |> P.getA |> NoneSelected)

        NoneSelected list ->
            list
                |> P.fromList
                |> Maybe.andThen (P.goTo idx)
                |> Maybe.map Selected
                |> Maybe.withDefault (NoneSelected list)


update : Op a -> Selector a -> ( Selector a, Maybe a )
update op selector =
    case op of
        Up ->
            ( selector |> moveL, Nothing )

        Down ->
            ( selector |> moveR, Nothing )

        Enter ->
            ( emptySelector, selector |> selected )

        Esc ->
            ( emptySelector, Nothing )

        OnHover id ->
            ( selector |> moveAt id, Nothing )

        OnClick id ->
            ( emptySelector, selector |> moveAt id |> selected )

        NoOp ->
            ( selector, Nothing )


selected : Selector a -> Maybe a
selected selector =
    case selector of
        Selected a ->
            a |> P.getC |> Just

        NoneSelected _ ->
            Nothing


emptySelector : Selector a
emptySelector =
    NoneSelected []


unselect : Selector a -> Selector a
unselect selector =
    case selector of
        NoneSelected a ->
            selector

        Selected selector ->
            selector |> P.getA |> NoneSelected


filteredSelector : (String -> a -> Bool) -> String -> List a -> Selector a
filteredSelector filter str selector =
    if str |> String.isEmpty then
        emptySelector
    else
        selector |> List.filter (filter str) |> NoneSelected


viewSelector : (( Int, a ) -> b) -> (( Int, a ) -> b) -> Selector a -> List b
viewSelector viewSelected viewUnselected selector =
    case selector of
        Selected pivot ->
            pivot |> P.zip |> P.mapCLR viewSelected viewUnselected viewUnselected |> P.getA

        NoneSelected list ->
            list |> List.indexedMap (,) |> List.map viewUnselected


showSelector selector =
    case selector of
        Selected a ->
            True

        NoneSelected a ->
            if a |> List.isEmpty then
                False
            else
                True


filterList : String -> String -> Bool
filterList filter toFilter =
    String.startsWith (filter |> String.toLower) (toFilter |> String.toLower)


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (JD.map tagger keyCode)

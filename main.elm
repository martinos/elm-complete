module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput, onBlur)
import Html.Attributes exposing (style, value)
import Keyboard as K
import Selector as S
import SelectorView exposing (..)


type alias Model =
    { selector : S.State String
    }


model : Model
model =
    { selector = S.initState |> S.setData [ "teksavvy", "swifvox", "ccom", "caspian", "ispt" ]
    }


type Msg
    = Select (S.Op String)


main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


update msg model =
    case msg of
        Select op ->
            ( { model | selector = model.selector |> S.updateSelector op }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ selectorInput "Account Name" model.selector |> Html.map Select ]


selectionStyle =
    [ ( "padding", "8px 15px" ), ( "display", "list-item" ) ]


viewUnselected : String -> Html msg
viewUnselected elem =
    li [ style selectionStyle ] [ elem |> text ]


viewSelected : String -> Html msg
viewSelected elem =
    li [ style (( "background-color", "#EEEEEE" ) :: selectionStyle) ]
        [ b [] [ elem |> text ] ]

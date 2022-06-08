module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random

main =
    Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type alias Model =
    { number: Number
    }

init : () -> (Model, Cmd Msg)
init _ =
    ( Model (Integer 0)
    , Cmd.none
    )

type Number
    = Integer Int
    | Float Float

numberToString : Number -> String
numberToString number =
    case number of
        Integer val ->
            String.fromInt val

        Float val ->
            String.fromFloat val

type Msg
    = Decimal
    | Whole
    | Update Number

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Whole ->
            ( model
            , Random.generate (Integer >> Update) (Random.int 0 10)
            )

        Decimal ->
            ( model
            , Random.generate (Float >> Update) (Random.float 0 1)
            )

        Update num ->
            ( Model num
            , Cmd.none
            )

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "ben7g NUMBER MACHINE (but in elm)" ]
        , p [] [ text (numberToString model.number) ]
        , button [ onClick Decimal ] [ text "Try it" ]
        , button [ onClick Whole ] [ text "Try it but whole!" ]
        ]
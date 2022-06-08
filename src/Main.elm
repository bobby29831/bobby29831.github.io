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
    { number: Float
    }

init : () -> (Model, Cmd Msg)
init _ =
    ( Model 0.0
    , Cmd.none
    )

type Msg
    = Decimal
    | Update Float

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Decimal ->
            ( model
            , Random.generate Update (Random.float 0 1)
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
        , p [] [ text (String.fromFloat model.number) ]
        , button [ onClick Decimal ] [ text "Try it" ]
        ]
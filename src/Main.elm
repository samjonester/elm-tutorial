module Main exposing (..)

import Navigation

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route, routeFromResult, parser)

-- Init

init :  Result String Route -> (Model, Cmd Msg)
init result =
    let
        currentRoute = routeFromResult result
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- MAIN

urlUpdate : Result String Route -> Model -> (Model, Cmd Msg)
urlUpdate result model =
    let
        currentRoute = routeFromResult result
    in
        ( {model | route = currentRoute }, Cmd.none )

main : Program Never
main =
    Navigation.program parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }

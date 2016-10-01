module View exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..))
import Players.List
import Players.Edit
import Players.Models exposing (PlayerId, Player)


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            Html.App.map PlayersMsg (Players.List.view model.players)
        PlayerRoute playerId ->
            playerEditPage model playerId
        NotFoundRoute ->
            notFoundView

playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    let
        maybePlayer =
            find (playerIdMatch playerId) model.players
    in
        case maybePlayer of
            Just player ->
                Html.App.map PlayersMsg (Players.Edit.view player)
            Nothing ->
                notFoundView

notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not found"
        ]


find : (a -> Bool) -> List a -> Maybe a
find predicate = List.filter predicate >> List.head

playerIdMatch : PlayerId -> Player -> Bool
playerIdMatch playerId player = player.id == playerId

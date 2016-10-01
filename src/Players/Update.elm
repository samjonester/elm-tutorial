module Players.Update exposing (..)

import Navigation

import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player, PlayerId)
import Players.Commands exposing (save)

update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        FetchAllDone newPlayers ->
            ( newPlayers, Cmd.none )
        FetchAllFail error ->
            ( players, Cmd.none )
        ShowPlayers ->
            ( players, Navigation.newUrl "#players" )
        ShowPlayer playerId ->
            ( players, Navigation.newUrl ("#players/" ++ (toString playerId)) )
        ChangeLevel playerId howMuch ->
            ( players, changeLevelCommands playerId howMuch players |> Cmd.batch )
        SaveSuccess player ->
            ( updatePlayer player players, Cmd.none )
        SaveFailure error ->
            ( players, Cmd.none )

changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch =
    let
        cmdForPlayer existingPlayer =
            if playerId == existingPlayer.id then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
    List.map cmdForPlayer

updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select

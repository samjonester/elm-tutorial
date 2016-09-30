module Players.Commands exposing (fetchAll)

import Http
import Task
import Json.Decode as Decode exposing ((:=))

import Players.Messages exposing (..)
import Players.Models exposing (..)

fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone

fetchAllUrl : String
fetchAllUrl = "http://localhost:4000/players"

collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder

memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.object3 Player
        ( "id" := Decode.int )
        ( "name" := Decode.string )
        ( "level" := Decode.int )

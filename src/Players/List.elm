module Players.List exposing (view)

import Html exposing (Html, div, text, table, thead, tbody, tr, th, td, button, i)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Players.Models exposing (Player)
import Players.Messages exposing (Msg(..))

view : List Player -> Html Msg
view players =
    div []
        [ nav
        , list players
        ]

nav : Html Msg
nav =
        div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]

list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
              [ thead []
                    [ tr []
                          [ th [] [ text "Id" ]
                          , th [] [ text "Name" ]
                          , th [] [ text "Level" ]
                          , th [] [ text "Actions" ]
                          ]
                    ]
              , tbody [] (List.map playerRow players)
              ]
        ]

playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text ( toString player.id ) ]
        , td [] [ text player.name ]
        , td [] [ text ( toString player.level ) ]
        , td [] [ editBtn player ]
        ]

editBtn : Player -> Html Msg
editBtn player =
    button [ class "btn regular"
           , onClick (ShowPlayer player.id)
           ]
        [ i [ class "fa fa-pencil mr1" ] []
        , text "Edit"
        ]

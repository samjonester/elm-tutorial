module Players.Edit exposing (view)

import Html exposing (Html, div, h1, text, span, a, i)
import Html.Attributes exposing (class)

import Players.Messages exposing (Msg)
import Players.Models exposing (Player)

view : Player -> Html Msg
view player =
    div []
        [ nav
        , form player
        ]

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black p1" ]
        []

form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 [] [text player.name ]
        , formLevel player
        ]

formLevel : Player -> Html Msg
formLevel player =
    div [ class "clearfix py1" ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]

btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    a [ class "btn ml1 h1" ]
        [ i [ class "fa fa-minus-circle" ] [] ]

btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1" ]
        [ i [ class "fa fa-plus-circle" ] [] ]

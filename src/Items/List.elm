module Items.List exposing (..)

import Html exposing (Html, div, text, input, textarea, a, label)
import Html.Attributes exposing (class, type_, readonly, name, checked)
import Html.Events exposing (onCheck)
import Models exposing (Item)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)


view : WebData (List Item) -> Html Msg
view response =
    div [ class "box" ]
        [ control
        , maybeList response
        ]


control : Html Msg
control =
    div [ class "level" ]
        [ div [ class "level-left" ]
            [ newButton ]
        , div [ class "level-item" ]
            [ filter ]
        ]


filter : Html Msg
filter =
    div [ class "control" ]
        [ label [ class "radio" ]
            [ input [ type_ "radio", name "filter" ] []
            , text "Not completed"
            ]
        , label [ class "radio" ]
            [ input [ type_ "radio", name "filter" ] []
            , text "Completed"
            ]
        , label [ class "radio" ]
            [ input [ type_ "radio", name "filter" ] []
            , text "All"
            ]
        ]


newButton : Html Msg
newButton =
    a [ class "button is-primary is-medium" ]
        [ text "+" ]


maybeList : WebData (List Item) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success items ->
            list items

        RemoteData.Failure error ->
            text (toString error)


list : List Item -> Html Msg
list items =
    div []
        (List.map itemRow items)


itemRow : Item -> Html Msg
itemRow item =
    div [ class "box level" ]
        [ div [ class "level-right" ]
            [ checkbox item ]
        , div [ class "level-item" ]
            [ content item ]
        , div [ class "level-left" ] [ editButton item ]
        ]


checkbox : Item -> Html Msg
checkbox item =
    input [ type_ "checkbox", checked item.checked, onCheck (CheckItem item) ]
        []


content : Item -> Html Msg
content item =
    div []
        [ text item.content ]


editButton : Item -> Html Msg
editButton item =
    a [ class "button is-primary is-medium" ]
        [ text "Edit" ]

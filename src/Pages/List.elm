module Pages.List exposing (..)

import Html exposing (Html, div, text, input, textarea, a, label, p)
import Html.Attributes exposing (class, classList, type_, readonly, name, checked, id)
import Html.Events exposing (onCheck)
import Models exposing (Item)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)


view : WebData (List Item) -> Html Msg
view response =
    div [ class "box" ]
        [ controls
        , maybeList response
        ]


controls : Html Msg
controls =
    div [ class "level" ]
        [ div [ class "level-left" ]
            [ newButton ]
        , div [ class "level-right" ]
            [ filter ]
        ]


newButton : Html Msg
newButton =
    a [ class "button is-primary is-medium" ]
        [ text "+ Add todo" ]


filter : Html Msg
filter =
    div [ class "field has-addons" ]
        [ p [ class "control" ]
            [ a [ class "button" ]
                [ text "Not completed" ]
            ]
        , p [ class "control" ]
            [ a [ class "button" ]
                [ text "Completed" ]
            ]
        , p [ class "control" ]
            [ a [ class "button" ]
                [ text "All" ]
            ]
        ]


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
        [ checkbox item
        , content item
        , rowButtons item
        ]


checkbox : Item -> Html Msg
checkbox item =
    input
        [ type_ "checkbox"
        , class "todo-checkbox"
        , checked item.checked
        , onCheck (CheckItem item)
        ]
        []


content : Item -> Html Msg
content item =
    div [ classList [ ( "has-text-grey-light line-through", item.checked ) ] ]
        [ text item.content ]


rowButtons : Item -> Html Msg
rowButtons item =
    div [ class "field is-grouped" ]
        [ p [ class "control" ]
            [ editButton item ]
        , p [ class "control" ]
            [ deleteButton item ]
        ]


editButton : Item -> Html Msg
editButton item =
    a [ class "button is-primary is-medium" ]
        [ text "Edit" ]


deleteButton : Item -> Html Msg
deleteButton item =
    a [ class "button is-danger is-medium" ]
        [ text "Delete" ]

module View exposing (..)

import Html exposing (Html, div, text, nav)
import Html.Attributes exposing (class)
import Models exposing (Model, ItemId)
import Msgs exposing (Msg)
import Pages.Edit
import Pages.List
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ header
        , div [ class "container" ]
            [ page model ]
        ]


header : Html Msg
header =
    nav [ class "navbar is-dark" ]
        [ div [ class "navbar-brand" ]
            [ div [ class "navbar-item" ]
                [ text "Elm Todo" ]
            ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.ListRoute ->
            Pages.List.view model.items

        Models.EditRoute itemId ->
            itemEditPage model itemId

        Models.NotFoundRoute ->
            notFoundView


itemEditPage : Model -> ItemId -> Html Msg
itemEditPage model itemId =
    case model.items of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success items ->
            let
                maybeItem =
                    items
                        |> List.filter (\item -> item.id == itemId)
                        |> List.head
            in
                case maybeItem of
                    Just item ->
                        Pages.Edit.view item

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found" ]

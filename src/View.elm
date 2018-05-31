module View exposing (view)

import Html exposing (Html, div, text, nav)
import Html.Attributes exposing (class)
import Models exposing (Model)
import Msgs exposing (Msg)
import Pages.List
import Pages.NewItem


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

        Models.NewItemRoute ->
            Pages.NewItem.view

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found" ]

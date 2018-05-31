module Pages.NewItem exposing (view)

import Html exposing (Html, div, textarea, a, text)
import Html.Attributes exposing (class, autofocus)
import Html.Events exposing (onInput, onClick)
import Msgs exposing (Msg(..))


view : Html Msg
view =
    div [ class "box" ]
        [ div [ class "field" ]
            [ inputArea ]
        , div [ class "field" ]
            [ saveButton ]
        ]


inputArea : Html Msg
inputArea =
    textarea [ class "textarea", onInput UpdateNewContent, autofocus True ]
        []


saveButton : Html Msg
saveButton =
    a [ class "button is-primary is-medium", onClick SubmitContent ]
        [ text "Save" ]

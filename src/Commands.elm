module Commands exposing (gotoLocationCmd, fetchItemsCmd, checkItemCmd, submitItemCmd, deleteItemCmd, filterItemsCmd)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Models exposing (Item, ItemId)
import Msgs exposing (Msg)
import Navigation
import RemoteData


--
-- Go to location
--


gotoLocationCmd : String -> Cmd Msg
gotoLocationCmd location =
    Navigation.newUrl location



--
-- Fetch items
--


fetch : String -> Cmd Msg
fetch url =
    Http.get url itemsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchItems


fetchItemsUrl : String
fetchItemsUrl =
    "http://localhost:4000/items"


fetchItemsCmd : Cmd Msg
fetchItemsCmd =
    fetch fetchItemsUrl


itemsDecoder : Decode.Decoder (List Item)
itemsDecoder =
    Decode.list itemDecoder


itemDecoder : Decode.Decoder Item
itemDecoder =
    decode Item
        |> required "id" Decode.string
        |> required "checked" Decode.bool
        |> required "content" Decode.string


itemUrl : ItemId -> String
itemUrl itemId =
    "http://localhost:4000/items/" ++ itemId



--
-- Filter items
--


filterItemsCmd : String -> Cmd Msg
filterItemsCmd filterValue =
    fetchItemsUrl
        ++ "?checked="
        ++ filterValue
        |> fetch



--
-- Check item
--


checkItemCmd : Item -> Cmd Msg
checkItemCmd item =
    saveItemRequest item
        |> Http.send Msgs.OnCheckItem


saveItemRequest : Item -> Http.Request Item
saveItemRequest item =
    Http.request
        { method = "PATCH"
        , headers = []
        , url = itemUrl item.id
        , body = itemEncoder item |> Http.jsonBody
        , expect = Http.expectJson itemDecoder
        , timeout = Nothing
        , withCredentials = False
        }


itemEncoder : Item -> Encode.Value
itemEncoder item =
    let
        attributes =
            [ ( "id", Encode.string item.id )
            , ( "checked", Encode.bool item.checked )
            , ( "content", Encode.string item.content )
            ]
    in
        Encode.object attributes



--
-- Submit item
--


submitItemCmd : String -> Cmd Msg
submitItemCmd newContent =
    submitItemRequest newContent
        |> Http.send Msgs.OnSubmitContent


postItemUrl : String
postItemUrl =
    "http://localhost:4000/items"


submitItemRequest : String -> Http.Request Item
submitItemRequest newContent =
    Http.request
        { method = "POST"
        , headers = []
        , url = postItemUrl
        , body = newItemEncoder newContent |> Http.jsonBody
        , expect = Http.expectJson itemDecoder
        , timeout = Nothing
        , withCredentials = False
        }


newItemEncoder : String -> Encode.Value
newItemEncoder newContent =
    let
        attributes =
            [ ( "checked", Encode.bool False )
            , ( "content", Encode.string newContent )
            ]
    in
        Encode.object attributes



--
-- Delete item
--


deleteItemCmd : ItemId -> Cmd Msg
deleteItemCmd itemId =
    deleteItemRequest itemId
        |> Http.send Msgs.OnDeleteItem


deleteItemRequest : ItemId -> Http.Request String
deleteItemRequest itemId =
    Http.request
        { method = "DELETE"
        , headers = []
        , url = itemUrl itemId
        , body = Http.emptyBody
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = False
        }

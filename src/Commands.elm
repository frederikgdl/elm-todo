module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Models exposing (Item, ItemId)
import Msgs exposing (Msg)
import RemoteData


fetchItemsUrl : String
fetchItemsUrl =
    "http://localhost:4000/items"


fetchItems : Cmd Msg
fetchItems =
    Http.get fetchItemsUrl itemsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchItems


itemsDecoder : Decode.Decoder (List Item)
itemsDecoder =
    Decode.list itemDecoder


itemDecoder : Decode.Decoder Item
itemDecoder =
    decode Item
        |> required "id" Decode.string
        |> required "checked" Decode.bool
        |> required "content" Decode.string


saveItemUrl : ItemId -> String
saveItemUrl itemId =
    "http://localhost:4000/items/" ++ itemId


checkItemCmd : Item -> Cmd Msg
checkItemCmd item =
    saveItemRequest item
        |> Http.send Msgs.OnCheckItem


saveItemRequest : Item -> Http.Request Item
saveItemRequest item =
    Http.request
        { body = itemEncoder item |> Http.jsonBody
        , expect = Http.expectJson itemDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveItemUrl item.id
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

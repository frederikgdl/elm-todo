module Update exposing (..)

import Commands exposing (checkItemCmd, deleteItemCmd, fetchItems)
import Models exposing (Model, Item)
import Msgs exposing (Msg)
import RemoteData
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchItems response ->
            ( { model | items = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.CheckItem item _ ->
            let
                updatedItem =
                    { item | checked = not item.checked }
            in
                ( model, checkItemCmd updatedItem )

        Msgs.OnCheckItem response ->
            case response of
                Ok item ->
                    ( updateItem model item, Cmd.none )

                Err error ->
                    ( model, Cmd.none )

        Msgs.DeleteItem itemId ->
            ( model, deleteItemCmd itemId )

        Msgs.OnDeleteItem response ->
            case response of
                Ok _ ->
                    ( model, fetchItems )

                Err error ->
                    ( model, Cmd.none )


updateItem : Model -> Item -> Model
updateItem model updatedItem =
    let
        pick currentItem =
            if updatedItem.id == currentItem.id then
                updatedItem
            else
                currentItem

        updateItemList items =
            List.map pick items

        updatedItems =
            RemoteData.map updateItemList model.items
    in
        { model | items = updatedItems }

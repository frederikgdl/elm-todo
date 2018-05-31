module Models exposing (Model, initialModel, ItemId, Item, Route(..))

import RemoteData exposing (WebData)


type alias Model =
    { items : WebData (List Item)
    , route : Route
    , newContent : String
    }


initialModel : Route -> Model
initialModel route =
    { items = RemoteData.Loading
    , route = route
    , newContent = ""
    }


type alias ItemId =
    String


type alias Item =
    { id : ItemId
    , checked : Bool
    , content : String
    }


type Route
    = ListRoute
    | NewItemRoute
    | NotFoundRoute

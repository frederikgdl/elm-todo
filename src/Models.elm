module Models exposing (Model, initialModel, ItemId, Item, Route(..))

import RemoteData exposing (WebData)


type alias Model =
    { items : WebData (List Item)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { items = RemoteData.Loading
    , route = route
    }


type alias ItemId =
    String


type alias Item =
    { id : ItemId
    , checked : Bool
    , content : String
    }


type Route
    = ItemsRoute
    | ItemRoute ItemId
    | NotFoundRoute

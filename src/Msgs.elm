module Msgs exposing (Msg(..))

import Http
import Models exposing (Item, ItemId, Filter)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchItems (WebData (List Item))
    | OnLocationChange Location
    | CheckItem Item Bool
    | OnCheckItem (Result Http.Error Item)
    | DeleteItem ItemId
    | OnDeleteItem (Result Http.Error String)
    | UpdateNewContent String
    | SubmitContent
    | OnSubmitContent (Result Http.Error Item)
    | FilterItems Filter

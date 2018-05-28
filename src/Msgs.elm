module Msgs exposing (Msg(..))

import Http
import Models exposing (Item, ItemId)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchItems (WebData (List Item))
    | OnLocationChange Location
    | CheckItem Item Bool
    | OnCheckItem (Result Http.Error Item)



-- | DeleteItem ItemId
-- | OnDeleteItem (Result Http.Error Item)
-- | SubmitContent String
-- | OnSubmitContent (Result Http.Error Item)

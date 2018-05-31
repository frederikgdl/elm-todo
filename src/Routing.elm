module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (ItemId, Route(..))
import UrlParser exposing (Parser, s, map, top, (</>), parseHash, oneOf, string)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map ListRoute top
        , map EditRoute (s "todo" </> string)
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


itemsPath : String
itemsPath =
    "#todo"


itemPath : ItemId -> String
itemPath id =
    "#todo/" ++ id

module Routing exposing (parseLocation, newItemPath)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (Parser, s, map, top, parseHash, oneOf)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map ListRoute top
        , map NewItemRoute (s "new")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


newItemPath : String
newItemPath =
    "#new"

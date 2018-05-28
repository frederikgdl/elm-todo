module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (ItemId, Route(..))
import UrlParser exposing (Parser, s, map, top, (</>), parseHash, oneOf, string)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map ItemsRoute top
        , map ItemRoute (s "players" </> string)
        , map ItemsRoute (s "players")
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
    "#items"


itemPath : ItemId -> String
itemPath id =
    "#items/" ++ id

-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Swapi.Object.Droid exposing (..)

import CustomScalarCodecs
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import Swapi.Enum.Episode
import Swapi.InputObject
import Swapi.Interface
import Swapi.Object
import Swapi.Scalar
import Swapi.Union


{-| Which movies they appear in.
-}
appearsIn : SelectionSet (List Swapi.Enum.Episode.Episode) Swapi.Object.Droid
appearsIn =
    Object.selectionForField "(List Enum.Episode.Episode)" "appearsIn" [] (Swapi.Enum.Episode.decoder |> Decode.list)


{-| Url to a profile picture for the character.
-}
avatarUrl : SelectionSet String Swapi.Object.Droid
avatarUrl =
    Object.selectionForField "String" "avatarUrl" [] Decode.string


{-| The friends of the droid, or an empty list if they have none.
-}
friends : SelectionSet decodesTo Swapi.Interface.Character -> SelectionSet (List decodesTo) Swapi.Object.Droid
friends object_ =
    Object.selectionForCompositeField "friends" [] object_ (identity >> Decode.list)


{-| The ID of the droid.
-}
id : SelectionSet CustomScalarCodecs.Id Swapi.Object.Droid
id =
    Object.selectionForField "CustomScalarCodecs.Id" "id" [] (CustomScalarCodecs.codecs |> Swapi.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| The name of the droid.
-}
name : SelectionSet String Swapi.Object.Droid
name =
    Object.selectionForField "String" "name" [] Decode.string


{-| The primary function of the droid.
-}
primaryFunction : SelectionSet (Maybe String) Swapi.Object.Droid
primaryFunction =
    Object.selectionForField "(Maybe String)" "primaryFunction" [] (Decode.string |> Decode.nullable)

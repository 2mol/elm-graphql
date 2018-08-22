-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Swapi.Object.Human exposing (appearsIn, avatarUrl, friends, homePlanet, id, name, selection)

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(..))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import Swapi.Enum.Episode
import Swapi.InputObject
import Swapi.Interface
import Swapi.Object
import Swapi.Scalar
import Swapi.Union


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Swapi.Object.Human
selection constructor =
    Object.selection constructor


{-| Which movies they appear in.
-}
appearsIn : Field (List Swapi.Enum.Episode.Episode) Swapi.Object.Human
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Swapi.Enum.Episode.decoder |> Decode.list)


{-| Url to a profile picture for the character.
-}
avatarUrl : Field String Swapi.Object.Human
avatarUrl =
    Object.fieldDecoder "avatarUrl" [] Decode.string


{-| The friends of the human, or an empty list if they have none.
-}
friends : SelectionSet decodesTo Swapi.Interface.Character -> Field (List decodesTo) Swapi.Object.Human
friends object_ =
    Object.selectionField "friends" [] object_ (identity >> Decode.list)


{-| The home planet of the human, or null if unknown.
-}
homePlanet : Field (Maybe String) Swapi.Object.Human
homePlanet =
    Object.fieldDecoder "homePlanet" [] (Decode.string |> Decode.nullable)


{-| The ID of the human.
-}
id : Field Swapi.Scalar.Id Swapi.Object.Human
id =
    Object.fieldDecoder "id"
        []
        (Decode.oneOf
            [ Decode.string
            , Decode.float |> Decode.map String.fromFloat
            , Decode.int |> Decode.map String.fromInt
            , Decode.bool
                |> Decode.map
                    (\bool ->
                        if bool then
                            "True"

                        else
                            "False"
                    )
            ]
            |> Decode.map Swapi.Scalar.Id
        )


{-| The name of the human.
-}
name : Field String Swapi.Object.Human
name =
    Object.fieldDecoder "name" [] Decode.string

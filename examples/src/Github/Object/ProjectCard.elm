-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Github.Object.ProjectCard exposing (..)

import Github.Enum.ProjectCardState
import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.ScalarCodecs
import Github.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| The project column this card is associated under. A card may only belong to one
project column at a time. The column field will be null if the card is created
in a pending state and has yet to be associated with a column. Once cards are
associated with a column, they will not become pending in the future.
-}
column : SelectionSet decodesTo Github.Object.ProjectColumn -> SelectionSet (Maybe decodesTo) Github.Object.ProjectCard
column object_ =
    Object.selectionForCompositeField "column" [] object_ (identity >> Decode.nullable)


{-| The card content item
-}
content : SelectionSet decodesTo Github.Union.ProjectCardItem -> SelectionSet (Maybe decodesTo) Github.Object.ProjectCard
content object_ =
    Object.selectionForCompositeField "content" [] object_ (identity >> Decode.nullable)


{-| Identifies the date and time when the object was created.
-}
createdAt : SelectionSet Github.ScalarCodecs.DateTime Github.Object.ProjectCard
createdAt =
    Object.selectionForField "ScalarCodecs.DateTime" "createdAt" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)


{-| The actor who created this card
-}
creator : SelectionSet decodesTo Github.Interface.Actor -> SelectionSet (Maybe decodesTo) Github.Object.ProjectCard
creator object_ =
    Object.selectionForCompositeField "creator" [] object_ (identity >> Decode.nullable)


{-| Identifies the primary key from the database.
-}
databaseId : SelectionSet (Maybe Int) Github.Object.ProjectCard
databaseId =
    Object.selectionForField "(Maybe Int)" "databaseId" [] (Decode.int |> Decode.nullable)


id : SelectionSet Github.ScalarCodecs.Id Github.Object.ProjectCard
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| The card note
-}
note : SelectionSet (Maybe String) Github.Object.ProjectCard
note =
    Object.selectionForField "(Maybe String)" "note" [] (Decode.string |> Decode.nullable)


{-| The project that contains this card.
-}
project : SelectionSet decodesTo Github.Object.Project -> SelectionSet decodesTo Github.Object.ProjectCard
project object_ =
    Object.selectionForCompositeField "project" [] object_ identity


{-| The column that contains this card.
-}
projectColumn : SelectionSet decodesTo Github.Object.ProjectColumn -> SelectionSet decodesTo Github.Object.ProjectCard
projectColumn object_ =
    Object.selectionForCompositeField "projectColumn" [] object_ identity


{-| The HTTP path for this card
-}
resourcePath : SelectionSet Github.ScalarCodecs.Uri Github.Object.ProjectCard
resourcePath =
    Object.selectionForField "ScalarCodecs.Uri" "resourcePath" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecUri |> .decoder)


{-| The state of ProjectCard
-}
state : SelectionSet (Maybe Github.Enum.ProjectCardState.ProjectCardState) Github.Object.ProjectCard
state =
    Object.selectionForField "(Maybe Enum.ProjectCardState.ProjectCardState)" "state" [] (Github.Enum.ProjectCardState.decoder |> Decode.nullable)


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : SelectionSet Github.ScalarCodecs.DateTime Github.Object.ProjectCard
updatedAt =
    Object.selectionForField "ScalarCodecs.DateTime" "updatedAt" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)


{-| The HTTP URL for this card
-}
url : SelectionSet Github.ScalarCodecs.Uri Github.Object.ProjectCard
url =
    Object.selectionForField "ScalarCodecs.Uri" "url" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecUri |> .decoder)

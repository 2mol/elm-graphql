-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.Ref exposing (AssociatedPullRequestsOptionalArguments, associatedPullRequests, id, name, prefix, repository, selection, target)

import Github.Enum.PullRequestState
import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.Union
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(..))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Ref
selection constructor =
    Object.selection constructor


type alias AssociatedPullRequestsOptionalArguments =
    { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Github.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Github.InputObject.IssueOrder }


{-| A list of pull requests with this ref as the head ref.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - states - A list of states to filter the pull requests by.
  - labels - A list of label names to filter the pull requests by.
  - headRefName - The head ref name to filter the pull requests by.
  - baseRefName - The base ref name to filter the pull requests by.
  - orderBy - Ordering options for pull requests returned from the connection.

-}
associatedPullRequests : (AssociatedPullRequestsOptionalArguments -> AssociatedPullRequestsOptionalArguments) -> SelectionSet decodesTo Github.Object.PullRequestConnection -> Field decodesTo Github.Object.Ref
associatedPullRequests fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, states = Absent, labels = Absent, headRefName = Absent, baseRefName = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum Github.Enum.PullRequestState.toString |> Encode.list), Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "headRefName" filledInOptionals.headRefName Encode.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy Github.InputObject.encodeIssueOrder ]
                |> List.filterMap identity
    in
    Object.selectionField "associatedPullRequests" optionalArgs object_ identity


id : Field Github.Scalar.Id Github.Object.Ref
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
            |> Decode.map Github.Scalar.Id
        )


{-| The ref name.
-}
name : Field String Github.Object.Ref
name =
    Object.fieldDecoder "name" [] Decode.string


{-| The ref's prefix, such as `refs/heads/` or `refs/tags/`.
-}
prefix : Field String Github.Object.Ref
prefix =
    Object.fieldDecoder "prefix" [] Decode.string


{-| The repository the ref belongs to.
-}
repository : SelectionSet decodesTo Github.Object.Repository -> Field decodesTo Github.Object.Ref
repository object_ =
    Object.selectionField "repository" [] object_ identity


{-| The object the ref points to.
-}
target : SelectionSet decodesTo Github.Interface.GitObject -> Field decodesTo Github.Object.Ref
target object_ =
    Object.selectionField "target" [] object_ identity

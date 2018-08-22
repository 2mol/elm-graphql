-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Interface.Labelable exposing (LabelsOptionalArguments, commonSelection, labels, onIssue, onPullRequest, selection)

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
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Json.Decode as Decode


{-| Select only common fields from the interface.
-}
commonSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.Labelable
commonSelection constructor =
    Object.selection constructor


{-| Select both common and type-specific fields from the interface.
-}
selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.Labelable) -> SelectionSet (a -> constructor) Github.Interface.Labelable
selection constructor typeSpecificDecoders =
    Object.interfaceSelection typeSpecificDecoders constructor


onIssue : SelectionSet decodesTo Github.Object.Issue -> FragmentSelectionSet decodesTo Github.Interface.Labelable
onIssue (SelectionSet fields decoder) =
    FragmentSelectionSet "Issue" fields decoder


onPullRequest : SelectionSet decodesTo Github.Object.PullRequest -> FragmentSelectionSet decodesTo Github.Interface.Labelable
onPullRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequest" fields decoder


type alias LabelsOptionalArguments =
    { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }


{-| A list of labels associated with the object.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
labels : (LabelsOptionalArguments -> LabelsOptionalArguments) -> SelectionSet decodesTo Github.Object.LabelConnection -> Field (Maybe decodesTo) Github.Interface.Labelable
labels fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionField "labels" optionalArgs object_ (identity >> Decode.nullable)

-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.MilestonedEvent exposing (actor, createdAt, id, milestoneTitle, selection, subject)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.MilestonedEvent
selection constructor =
    Object.selection constructor


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet decodesTo Github.Interface.Actor -> Field (Maybe decodesTo) Github.Object.MilestonedEvent
actor object_ =
    Object.selectionField "actor" [] object_ (identity >> Decode.nullable)


{-| Identifies the date and time when the object was created.
-}
createdAt : Field Github.Scalar.DateTime Github.Object.MilestonedEvent
createdAt =
    Object.fieldDecoder "createdAt"
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
            |> Decode.map Github.Scalar.DateTime
        )


id : Field Github.Scalar.Id Github.Object.MilestonedEvent
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


{-| Identifies the milestone title associated with the 'milestoned' event.
-}
milestoneTitle : Field String Github.Object.MilestonedEvent
milestoneTitle =
    Object.fieldDecoder "milestoneTitle" [] Decode.string


{-| Object referenced by event.
-}
subject : SelectionSet decodesTo Github.Union.MilestoneItem -> Field decodesTo Github.Object.MilestonedEvent
subject object_ =
    Object.selectionField "subject" [] object_ identity

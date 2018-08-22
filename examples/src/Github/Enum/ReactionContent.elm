-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Enum.ReactionContent exposing (ReactionContent(..), decoder, toString)

import Json.Decode as Decode exposing (Decoder)


{-| Emojis that can be attached to Issues, Pull Requests and Comments.

  - ThumbsUp - Represents the 👍 emoji.
  - ThumbsDown - Represents the 👎 emoji.
  - Laugh - Represents the 😄 emoji.
  - Hooray - Represents the 🎉 emoji.
  - Confused - Represents the 😕 emoji.
  - Heart - Represents the ❤️ emoji.

-}
type ReactionContent
    = ThumbsUp
    | ThumbsDown
    | Laugh
    | Hooray
    | Confused
    | Heart


decoder : Decoder ReactionContent
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "THUMBS_UP" ->
                        Decode.succeed ThumbsUp

                    "THUMBS_DOWN" ->
                        Decode.succeed ThumbsDown

                    "LAUGH" ->
                        Decode.succeed Laugh

                    "HOORAY" ->
                        Decode.succeed Hooray

                    "CONFUSED" ->
                        Decode.succeed Confused

                    "HEART" ->
                        Decode.succeed Heart

                    _ ->
                        Decode.fail ("Invalid ReactionContent type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : ReactionContent -> String
toString enum =
    case enum of
        ThumbsUp ->
            "THUMBS_UP"

        ThumbsDown ->
            "THUMBS_DOWN"

        Laugh ->
            "LAUGH"

        Hooray ->
            "HOORAY"

        Confused ->
            "CONFUSED"

        Heart ->
            "HEART"

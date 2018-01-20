module Subscription exposing (main)

import Graphqelm.Document
import Graphqelm.Operation exposing (RootSubscription)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Graphqelm.Subscription
import Html exposing (button, div, h1, li, p, pre, text, ul)
import Html.Events exposing (onClick)
import Json.Decode
import Json.Encode as Encode
import Swapi.Enum.Phrase as Phrase exposing (Phrase)
import Swapi.Interface
import Swapi.Interface.Character
import Swapi.Mutation as Mutation
import Swapi.Object
import Swapi.Object.ChatMessage
import Swapi.Scalar
import Swapi.Subscription as Subscription
import WebSocket


sendMessage : Phrase -> SelectionSet (Maybe ()) Graphqelm.Operation.RootMutation
sendMessage phrase =
    Mutation.selection identity
        |> with (Mutation.sendMessage { characterId = Swapi.Scalar.Id "1001", phrase = phrase } SelectionSet.empty)


document : SelectionSet ChatMessage RootSubscription
document =
    Subscription.selection identity
        |> with (Subscription.newMessage chatMessageSelection)


type alias ChatMessage =
    { phrase : Phrase
    , characterName : Maybe String
    }


chatMessageSelection : SelectionSet ChatMessage Swapi.Object.ChatMessage
chatMessageSelection =
    Swapi.Object.ChatMessage.selection ChatMessage
        |> with Swapi.Object.ChatMessage.phrase
        |> with (Swapi.Object.ChatMessage.character characterSelection)


characterSelection : SelectionSet String Swapi.Interface.Character
characterSelection =
    Swapi.Interface.Character.commonSelection identity
        |> with Swapi.Interface.Character.name


type alias Model =
    { data : List ChatMessage
    , subscriptionStatus : SubscriptionStatus
    , graphqlSubscriptionModel : Graphqelm.Subscription.Model Msg ChatMessage
    }


type SubscriptionStatus
    = Uninitialized
    | Connected


type Msg
    = SendMessage Phrase
    | GraphqlSubscriptionMsg (Graphqelm.Subscription.Msg ChatMessage)
    | SubscriptionDataReceived ChatMessage


init : ( Model, Cmd Msg )
init =
    let
        ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
            Graphqelm.Subscription.init socketUrl document SubscriptionDataReceived
    in
    ( { data = []
      , subscriptionStatus = Uninitialized
      , graphqlSubscriptionModel = graphqlSubscriptionModel
      }
    , graphqlSubscriptionCmd
    )


view : Model -> Html.Html Msg
view model =
    div []
        [ h1 [] [ text "Star Chat" ]
        , text ("Phoenix GraphQL Subscription connection status: " ++ toString model.subscriptionStatus)
        , messageButtons
        , chatMessagesView model.data
        ]


messageButtons : Html.Html Msg
messageButtons =
    div []
        [ messageButton Phrase.Faith
        , messageButton Phrase.Father
        , messageButton Phrase.Help
        , messageButton Phrase.TheForce
        , messageButton Phrase.Try
        ]


messageButton : Phrase -> Html.Html Msg
messageButton phrase =
    button [ onClick (SendMessage phrase) ] [ phrase |> toString |> text ]


chatMessagesView : List ChatMessage -> Html.Html msg
chatMessagesView model =
    ul []
        (model
            |> List.map
                (\{ phrase, characterName } ->
                    li [] [ ((characterName |> Maybe.withDefault "") ++ ": " ++ (phrase |> phraseToString)) |> text ]
                )
        )


phraseToString : Phrase -> String
phraseToString phrase =
    case phrase of
        Phrase.Faith ->
            "I find your lack of faith disturbing."

        Phrase.Father ->
            "I am your father."

        Phrase.Help ->
            "Help me, Obi-Wan Kenobi. You're my only hope."

        Phrase.TheForce ->
            "May the Force be with you."

        Phrase.Try ->
            "Do, or do not, there is no try."


socketUrl : String
socketUrl =
    "wss://graphqelm.herokuapp.com/socket/websocket?vsn=2.0.0"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GraphqlSubscriptionMsg graphqlSubscriptionMsg ->
            Graphqelm.Subscription.update graphqlSubscriptionMsg model

        SendMessage phrase ->
            ( model, WebSocket.send socketUrl (documentRequest (Graphqelm.Document.serializeMutation (sendMessage phrase))) )

        SubscriptionDataReceived newData ->
            ( { model | data = newData :: model.data }, Cmd.none )


initMessage : String
initMessage =
    Encode.list
        [ Encode.string "1"
        , Encode.string "1"
        , Encode.string "__absinthe__:control"
        , Encode.string "phx_join"
        , Encode.object []
        ]
        |> Encode.encode 0


heartBeatMessage : String
heartBeatMessage =
    Encode.list
        [ Encode.null
        , Encode.string "1"
        , Encode.string "phoenix"
        , Encode.string "heartbeat"
        , Encode.object []
        ]
        |> Encode.encode 0


documentRequest : String -> String
documentRequest operation =
    Encode.list
        [ Encode.string "1"
        , Encode.string "1"
        , Encode.string "__absinthe__:control"
        , Encode.string "doc"
        , Encode.object [ ( "query", operation |> Encode.string ) ]
        ]
        |> Encode.encode 0


subscriptions : Model -> Sub Msg
subscriptions model =
    Graphqelm.Subscription.subscription GraphqlSubscriptionMsg socketUrl document


subscriptionDecoder : Json.Decode.Decoder a -> String -> Result String (SubscriptionResponse a)
subscriptionDecoder decoder response =
    response
        |> Json.Decode.decodeString
            (subscriptionResponseDecoder
                (decoder
                    |> Json.Decode.field "result"
                    |> Json.Decode.index 4
                )
            )


subscriptionResponseDecoder : Json.Decode.Decoder a -> Json.Decode.Decoder (SubscriptionResponse a)
subscriptionResponseDecoder decoder =
    Json.Decode.index 3 Json.Decode.string
        |> Json.Decode.andThen
            (\responseType ->
                if responseType == "subscription:data" then
                    decoder |> Json.Decode.map SubscriptionData
                else
                    Json.Decode.succeed HealthStatus
            )


type SubscriptionResponse a
    = SubscriptionData a
    | HealthStatus


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
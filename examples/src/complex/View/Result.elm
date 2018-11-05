module View.Result exposing (view)

import Element exposing (Element, text)
import ElmReposRequest
import Github.Scalar
import Html exposing (Html, a, button, div, h1, img, p, pre)
import Html.Attributes exposing (href, src, style, target)


view : ElmReposRequest.Repo -> Element msg
view result =
    Element.row []
        [ avatarView result.owner.avatarUrl |> Element.html
        , repoLink result.name result.url
        , text ("⭐️" ++ String.fromInt result.stargazerCount)
        , text ("🍴" ++ String.fromInt result.forkCount)
        , text (" Created: " ++ dateTimeToString result.timestamps.created)
        , text (" Updated: " ++ dateTimeToString result.timestamps.updated)
        ]


dateTimeToString dateTimeString =
    dateTimeString


avatarView : Github.Scalar.Uri -> Html msg
avatarView (Github.Scalar.Uri avatarUrl) =
    img [ src avatarUrl, style "width" "35px" ] []


repoLink : String -> Github.Scalar.Uri -> Element msg
repoLink repoName (Github.Scalar.Uri repoUrl) =
    Element.newTabLink [] { url = repoUrl, label = text repoName }

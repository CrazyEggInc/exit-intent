port module Main exposing (..)

import Html exposing (Html, a, div, h1, p, program, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)

type alias Model =
    { isVisible : Bool
    , content : Content
    }

type alias Content =
    { headline : String
    , subHeadline : String
    , actions : List Action
    , image : Maybe Image
    }

type alias Action =
    { text : String
    , location : String
    , track : Bool
    }

type alias Image =
    { source : String
    }

type Msg
    = UpdateContent Content
    | UpdateVisible Bool

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

initialModel : Model
initialModel =
    Model False initialContent

initialContent : Content
initialContent =
    Content "" "" [] Nothing

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ modalContent UpdateContent
        , modalVisible UpdateVisible
        ]

port modalContent : (Content -> msg) -> Sub msg

port modalVisible : (Bool -> msg) -> Sub msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateContent content ->
            ( { model | content = content }, Cmd.none )

        UpdateVisible bool ->
            ( { model | isVisible = bool }, Cmd.none )

view : Model -> Html Msg
view model =
    if model.isVisible then
        div [ class "modal" ]
            [ headline model.content
            , actions model.content.actions
            , closeButton
            ]
    else
        text ""

headline : Content -> Html Msg
headline content =
    div [ class "headline-wrapper" ]
        [ h1 [] [ text content.headline ]
        , p [] [ text content.subHeadline ]
        ]

actions : List Action -> Html Msg
actions actions =
    div [ class "actions" ] (List.map action actions)

action : Action -> Html Msg
action action =
    a [ href action.location ] [ text action.text ]

closeButton : Html Msg
closeButton =
    a [ onClick (UpdateVisible False), class "modal-close" ] [ text "" ]

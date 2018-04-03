port module Main exposing (..)


import Html exposing (Html, a, div, h1, p, program, text)
import Html.Attributes exposing (class, href, style)
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
    modal model


modal : Model -> Html Msg
modal model =
    case model.isVisible of
        True ->
            div [ class "modal", style modalStyle ]
                [ headline model.content
                , actions model.content.actions
                , closeButton
                ]
        _ ->
            text ""


headline : Content -> Html Msg
headline content =
    div [ class "headline-wrapper" ]
        [ h1 [] [ text content.headline ]
        , p [] [ text content.subHeadline ]
        ]


actions : List Action -> Html Msg
actions actions =
    div [ class "actions", style actionsContainerStyle ] (List.map action actions)


action : Action -> Html Msg
action action =
    a [ href action.location, style actionStyle ] [ text action.text ]


closeButton : Html Msg
closeButton =
    a [ onClick (UpdateVisible False), class "modal-close", style closeModalStyle ] [ text "x" ]


-- Styles

modalStyle : List (String, String)
modalStyle =
    [ ("width", "500px")
    , ("height", "400px")
    , ("position", "absolute")
    , ("top", "50%")
    , ("left", "50%")
    , ("margin-top", "-200px")
    , ("margin-left", "-250px")
    , ("background-color", "white")
    , ("border", "1px solid darkgray")
    , ("border-radius", "10px")
    , ("z-index", "99")
    , ("text-align", "center")
    ]


closeModalStyle : List(String, String)
closeModalStyle =
    [ ("position", "absolute")
    , ("top", "10px")
    , ("right", "25px")
    , ("content", "✕")
    , ("cursor", "pointer")
    ]


actionsContainerStyle : List(String, String)
actionsContainerStyle =
    [ ("position", "absolute")
    , ("bottom", "30px")
    ]


actionStyle : List(String, String)
actionStyle =
    [ ("padding", "10px")
    , ("border", "1px solid lightgray")
    , ("border-radius", "10px")
    ]

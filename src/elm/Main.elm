port module Main exposing (..)

import Html exposing (Html, a, div, h1, img, li, p, program, text, ul)
import Html.Attributes exposing (class, href, src, style)
import Html.Events exposing (onClick)


type alias Model =
    { isVisible : Bool
    , modal : Modal
    }


type alias Modal =
    { headline : Text
    , content : Text
    , actions : List Action
    , image : Image
    , globalConfig : GlobalConfig
    }


type alias GlobalConfig =
    { styles : List Style }


type alias Text =
    { text : String
    , styles : List Style
    }


type alias Action =
    { text : String
    , location : String
    , event : String
    , styles : List Style
    }


type alias Image =
    { source : String
    , styles : List Style
    }


type alias Style =
    ( String, String )


type Msg
    = UpdateModal Modal
    | UpdateVisible Bool
    | HandleActionEvent Action


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
    Model False initialModal


initialModal : Modal
initialModal =
    Modal initialHeadline initialContent [] initialImage initialGlobalConfig


initialHeadline : Text
initialHeadline =
    Text "" []


initialContent : Text
initialContent =
    Text "" []


initialImage : Image
initialImage =
    Image "" []


initialGlobalConfig : GlobalConfig
initialGlobalConfig =
    GlobalConfig []


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ modalContent UpdateModal
        , modalVisible UpdateVisible
        ]



-- Ports


port modalContent : (Modal -> msg) -> Sub msg


port modalVisible : (Bool -> msg) -> Sub msg


port actionEvent : Action -> Cmd msg


port closeEvent : Bool -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateModal modal ->
            ( { model | modal = modal }, Cmd.none )

        UpdateVisible bool ->
            ( { model | isVisible = bool }, closeEvent bool )

        HandleActionEvent action ->
            ( model, actionEvent action )


view : Model -> Html Msg
view model =
    modal model


modal : Model -> Html Msg
modal model =
    case model.isVisible of
        True ->
            div [ class "modal", style (modalStyle model.modal.globalConfig) ] [ modalContainer model.modal, closeButton ]

        _ ->
            text ""


modalContainer : Modal -> Html Msg
modalContainer content =
    div [ class "modal-content", style modalContainerStyle ]
        [ contentLeft content.image
        , contentRight content
        ]


contentLeft : Image -> Html Msg
contentLeft image =
    div [ class "content-left", style contentLeftStyle ]
        [ imageWrapper image ]


contentRight : Modal -> Html Msg
contentRight content =
    div [ class "content-right", style contentRightStyle ]
        [ headlineWrapper content
        , contentWrapper content
        , actionsWrapper content.actions
        ]


imageWrapper : Image -> Html Msg
imageWrapper image =
    img [ src image.source, style (imageStyle image.styles) ] []


headlineWrapper : Modal -> Html Msg
headlineWrapper content =
    div [ class "headline-wrapper", style headlineWrapperStyle ]
        [ headline content.headline ]


headline : Text -> Html Msg
headline headlineText =
    h1 [ style (headlineStyle headlineText.styles) ] [ text headlineText.text ]


contentWrapper : Modal -> Html Msg
contentWrapper modal =
    div [ class "content-wrapper", style contentWrapperStyle ]
        [ contentBody modal.content ]


contentBody : Text -> Html Msg
contentBody content =
    p [ style (contentBodyStyles content.styles) ] [ text content.text ]


actionsWrapper : List Action -> Html Msg
actionsWrapper actions =
    ul [ class "actions", style actionsContainerStyle ] (List.map actionItem actions)


actionItem : Action -> Html Msg
actionItem action =
    li [ href action.location, style actionWrapperStyle ]
        [ a [ style (actionStyle action.styles), onClick (HandleActionEvent action) ] [ text action.text ]
        ]


closeButton : Html Msg
closeButton =
    a [ onClick (UpdateVisible False), style closeModalStyle ] [ text "x" ]



-- Styles


modalStyle : GlobalConfig -> List ( String, String )
modalStyle globalConfig =
    let
        defaultStyles =
            [ ( "width", "100%" )
            , ( "height", "100%" )
            , ( "position", "fixed" )
            , ( "top", "0" )
            , ( "left", "0" )
            , ( "z-index", "99" )
            ]
    in
    List.concat [ defaultStyles, globalConfig.styles ]


headlineWrapperStyle : List ( String, String )
headlineWrapperStyle =
    [ ( "margin-top", "50px" ) ]


headlineStyle : List Style -> List ( String, String )
headlineStyle styles =
    let
        defaultStyles =
            [ ( "margin-bottom", "15px" ) ]
    in
    List.concat [ defaultStyles, styles ]


contentBodyStyles : List Style -> List ( String, String )
contentBodyStyles styles =
    let
        defaultStyles =
            []
    in
    List.concat [ defaultStyles, styles ]


modalContainerStyle : List ( String, String )
modalContainerStyle =
    [ ( "width", "835px" )
    , ( "height", "400px" )
    , ( "margin-left", "auto" )
    , ( "margin-right", "auto" )
    , ( "margin-top", "15%" )
    ]


contentWrapperStyle : List ( String, String )
contentWrapperStyle =
    []


closeModalStyle : List ( String, String )
closeModalStyle =
    [ ( "position", "absolute" )
    , ( "top", "20px" )
    , ( "right", "30px" )
    , ( "font-size", "40px" )
    , ( "color", "lightgray" )
    , ( "cursor", "pointer" )
    ]


contentLeftStyle : List ( String, String )
contentLeftStyle =
    [ ( "width", "40%" )
    , ( "height", "100%" )
    , ( "float", "left" )
    ]


contentRightStyle : List ( String, String )
contentRightStyle =
    [ ( "width", "60%" )
    , ( "height", "100%" )
    , ( "float", "left" )
    , ( "position", "relative" )
    , ( "padding", "15px" )
    , ( "box-sizing", "border-box" )
    , ( "padding-left", "70px" )
    ]


imageStyle : List Style -> List ( String, String )
imageStyle styles =
    let
        defaultStyles =
            [ ( "width", "280px" )
            , ( "float", "right" )
            , ( "margin-top", "25%" )
            ]
    in
    List.concat [ defaultStyles, styles ]


actionsContainerStyle : List ( String, String )
actionsContainerStyle =
    [ ( "display", "block" )
    , ( "bottom", "70px" )
    , ( "padding-left", "0" )
    ]


actionWrapperStyle : List ( String, String )
actionWrapperStyle =
    [ ( "list-style", "none" )
    , ( "margin-top", "15px" )
    , ( "text-align", "center" )
    ]


actionStyle : List Style -> List ( String, String )
actionStyle styles =
    let
        defaultStyles =
            [ ( "padding", "10px" )
            , ( "width", "280px" )
            , ( "border-radius", "5px" )
            , ( "display", "block" )
            , ( "text-decoration", "none" )
            , ( "color", "#FFF" )
            , ( "font-weight", "600" )
            , ( "cursor", "pointer" )
            ]
    in
    List.concat [ defaultStyles, styles ]

port module Main exposing (..)

import Html exposing (Html, a, div, h1, img, li, p, program, text, ul)
import Html.Attributes exposing (class, href, src, style)
import Html.Events exposing (onClick)


type alias Model =
    { isVisible : Bool
    , modal : Modal
    }


type alias Modal =
    { headline : String
    , content : String
    , actions : List Action
    , image : Image
    , globalStyles : List Style
    }


type alias Action =
    { text : String
    , location : String
    , styles : List Style
    }


type alias Image =
    { source : String
    }


type alias Style =
    ( String, String )


type Msg
    = UpdateModal Modal
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
    Model False initialModal


initialModal : Modal
initialModal =
    Modal "" "" [] initialImage []


initialImage : Image
initialImage =
    Image ""


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ modalContent UpdateModal
        , modalVisible UpdateVisible
        ]


port modalContent : (Modal -> msg) -> Sub msg


port modalVisible : (Bool -> msg) -> Sub msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateModal modal ->
            ( { model | modal = modal }, Cmd.none )

        UpdateVisible bool ->
            ( { model | isVisible = bool }, Cmd.none )


view : Model -> Html Msg
view model =
    modal model


modal : Model -> Html Msg
modal model =
    case model.isVisible of
        True ->
            div [ class "modal", style (modalStyle model.modal.globalStyles) ] [ modalContainer model.modal, closeButton ]

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
    img [ src image.source, style imageStyle ] []


headlineWrapper : Modal -> Html Msg
headlineWrapper content =
    div [ class "headline-wrapper", style headlineWrapperStyle ]
        [ headline content.headline ]


headline : String -> Html Msg
headline headlineText =
    h1 [ style headlineStyle ] [ text headlineText ]


contentWrapper : Modal -> Html Msg
contentWrapper modal =
    div [ class "content-wrapper", style contentWrapperStyle ]
        [ contentBody modal.content ]


contentBody : String -> Html Msg
contentBody content =
    p [ style contentBodyStyles ] [ text content ]


actionsWrapper : List Action -> Html Msg
actionsWrapper actions =
    ul [ class "actions", style actionsContainerStyle ] (List.map action actions)


action : Action -> Html Msg
action action =
    li [ href action.location, style (actionStyle action.styles) ] [ text action.text ]


closeButton : Html Msg
closeButton =
    a [ onClick (UpdateVisible False), class "modal-close", style closeModalStyle ] [ text "x" ]



-- Styles


modalStyle : List Style -> List ( String, String )
modalStyle globalStyles =
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
    List.concat [ defaultStyles, globalStyles ]


headlineWrapperStyle : List ( String, String )
headlineWrapperStyle =
    [ ( "margin-top", "50px" ) ]


headlineStyle : List ( String, String )
headlineStyle =
    [ ( "margin-bottom", "15px" ) ]


contentBodyStyles : List ( String, String )
contentBodyStyles =
    []


modalContainerStyle : List ( String, String )
modalContainerStyle =
    [ ( "width", "60%" )
    , ( "height", "400px" )
    , ( "margin-left", "auto" )
    , ( "margin-right", "auto" )
    , ( "margin-top", "20%" )
    ]


contentWrapperStyle : List ( String, String )
contentWrapperStyle =
    []


closeModalStyle : List ( String, String )
closeModalStyle =
    [ ( "position", "absolute" )
    , ( "top", "10px" )
    , ( "right", "25px" )
    , ( "content", "✕" )
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
    , ( "padding-left", "50px" )
    ]


imageStyle : List ( String, String )
imageStyle =
    [ ( "width", "280px" )
    , ( "float", "right" )
    , ( "margin-top", "25%" )
    ]


actionsContainerStyle : List ( String, String )
actionsContainerStyle =
    [ ( "position", "absolute" )
    , ( "display", "block" )
    , ( "bottom", "70px" )
    , ( "padding-left", "0" )
    ]


actionStyle : List Style -> List ( String, String )
actionStyle styles =
    let
        defaultStyles =
            [ ( "padding", "10px" )
            , ( "width", "200px" )
            , ( "border-radius", "3px" )
            , ( "list-style", "none" )
            , ( "margin-top", "15px" )
            , ( "text-align", "center" )
            ]
    in
    List.concat [ defaultStyles, styles ]

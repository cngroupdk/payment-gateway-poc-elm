module PaymentGateway exposing (main)

import Html exposing (Html, div, h1, h2, h3, input, text, button)

import Bootstrap.Grid.Col as Col
import Bootstrap.Grid as Grid
import Bootstrap.Form.Input as Input

import Account exposing (..)
import AccountResource exposing (fetchAccountRequestCmd)
import PaymentGatewayMessages as Msg exposing (..)


init : ( Model, Cmd Msg )
init =
  ( { paymentAmount = 0.0
    , emailAddress = ""
    , infoMessage = ""
    , account =
      { emailAddress = ""
      , accountNumber = ""
      }
    }
  , Cmd.none
  )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    EmailInputChange emailInput ->
      let
        newModel =
          { model
          | emailAddress = emailInput
          }
      in
        if (validateEmailAddress emailInput) then
          { newModel
          | infoMessage = "Valid email, fetching data"
          }
          |> update (FetchAccountRequest)
        else
          ( { newModel
            | infoMessage = "Not a valid email"
            }
          , Cmd.none)
    FetchAccountRequest ->
      ( model
      , fetchAccountRequestCmd model.emailAddress
      )
    FetchAccountResponse (Ok account) ->
      ( { model
        | account = account
        , infoMessage = "Account found: " ++ account.accountNumber
        }
      , Cmd.none
      )
    FetchAccountResponse (Err _) ->
      ( { model
        | infoMessage = "Valid email, unknown Account"
        }
      , Cmd.none
      )
    None ->
      (model, Cmd.none)


view : Model -> Html Msg
view model =
  Grid.container
    []
    [ Grid.row []
      [ Grid.col [ Col.xs12 ]
        [ (h1 [] [(text ("Amount to pay: " ++ (toString model.paymentAmount)))])]
      ]
    , Grid.row []
      [ Grid.col [ Col.xs12 ]
        [ (h2 [] [(text "Personal information")])]
      ]
    , Grid.row []
      [ Grid.col [ Col.xs12 ]
        [ Input.text
          [ Input.id "emailInput"
          , Input.large
          , Input.placeholder "john@doe.com"
          , Input.onInput EmailInputChange
          ]
        ]
      ]
    , Grid.row []
      [ Grid.col [ Col.xs12 ]
        [ (h3 [] [(text model.infoMessage)]) ]
      ]
    ]


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


main : Program Never Model Msg
main =
  Html.program
    { view = view
    , update = update
    , subscriptions = subscriptions
    , init = init
    }

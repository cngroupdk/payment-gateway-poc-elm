module PaymentGatewayMessages exposing (..)

import Http exposing (Error)

import Account exposing (..)


type Msg
    = EmailInputChange String
    | FetchAccountRequest
    | FetchAccountResponse (Result Http.Error Account)
    | None

module AccountResource exposing (..)

import Json.Decode exposing (..)
import Http exposing (..)


import Account exposing (..)
import PaymentGatewayMessages as Msg exposing (..)


accountUrl : String
accountUrl = "http://localhost:8888/api/accounts"


fetchAccountRequestCmd : String -> Cmd Msg
fetchAccountRequestCmd emailAddress =
  let
    getRequest = Http.get (accountUrl ++ "/" ++ emailAddress) accountJsonDecoder
  in
    Http.send Msg.FetchAccountResponse getRequest

accountJsonDecoder : Decoder Account.Account
accountJsonDecoder =
  map2 Account.Account
    (field "emailAddress" string)
    (field "accountNumber" string)

module Account exposing (..)

import Regex exposing (regex)


type alias EmailAddress = String

type alias Account =
  { emailAddress: EmailAddress
  , accountNumber: String
  }

type alias Model =
  { paymentAmount: Float
  , emailAddress: EmailAddress
  , infoMessage: String
  , account: Account
  }

emailRegex : String
emailRegex = "^\\w+@\\w+\\.\\w+$"

validateEmailAddress : String -> Bool
validateEmailAddress email =
  Regex.contains (regex emailRegex) email

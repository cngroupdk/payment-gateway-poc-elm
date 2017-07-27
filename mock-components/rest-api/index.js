'use strict'

const bodyParser = require('body-parser')
const express = require('express')


const AccountStore = require('./app/account/AccountStore.js')

const AccountEndpointModule = require('./app/account/AccountEndpoint.js')


const appPort = process.env.PORT || 8888


const app = express()
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())


const AccountStoreInitPromise = AccountStore.init()


Promise
  .all([AccountStoreInitPromise])
  .then(() => {
    const AccountEndpoint = AccountEndpointModule(AccountStore)

    AccountEndpoint.register(app)

    app.listen(appPort, () => {
      console.log(`REST/JSON API mock server started at: http://localhost:${appPort}`)
    })
  })

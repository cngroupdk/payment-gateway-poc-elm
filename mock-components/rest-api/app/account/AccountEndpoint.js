'use strict'

const apiResponse = require('../common/ApiResponse.js')


function AccountEndpoint(AccountStore) {

  const ENDPOINT = '/api/accounts'


  function register(app) {
    app.get(ENDPOINT, _getList)
    app.post(ENDPOINT, _post)
    app.put(ENDPOINT, apiResponse.http405)
    app.delete(ENDPOINT, _delete)

    app.get(`${ENDPOINT}/:email`, _getEntry)
  }

  function _getList(req, res) {
    console.log(`GET ${ENDPOINT}`)
    apiResponse.http200(req, res,
      {
        accounts: AccountStore.list()
      }
    )
  }

  function _getEntry(req, res) {
    const emailAddress = req.params.email
    console.log(`GET ${ENDPOINT}/${emailAddress}`)

    const entry = AccountStore.find(emailAddress)
    if (entry) {
      apiResponse.http200(req, res, entry)
    } else {
      apiResponse.http404(req, res)
    }
  }

  function _post(req, res) {
    console.log(`POST ${ENDPOINT}`)
    const emailAddress = req.body.emailAddress
    if (!emailAddress) {
      apiResponse.http400(req, res)
      return
    }

    AccountStore.add(emailAddress)
    apiResponse.http200(req, res, { message: 'success' })
  }

  function _delete(req, res) {
    console.log(`DELETE ${ENDPOINT}`)
    const emailAddress = req.body.emailAddress
    if (!emailAddress) {
      apiResponse.http400(req, res)
      return
    }

    AccountStore.remove(emailAddress)
    apiResponse.http200(req, res, { message: 'success' })
  }

  const api = {
    register:register
  }

  return api
}

module.exports = AccountEndpoint

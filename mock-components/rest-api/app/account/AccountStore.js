'use strict'

const _ = require('lodash')


function AccountStore() {

  let accounts = []


  function init() {
    return new Promise((resolve) => {
      const emailAddressData = require('../../data/accounts.json')
      accounts = _.cloneDeep(emailAddressData)
      resolve()
    })
  }

  function add(emailAddress) {
    accounts = _.concat(
      accounts,
      { emailAddress: emailAddress }
    )
  }

  function find(emailAddress) {
    return _.find(
      accounts,
      entry => entry.emailAddress === emailAddress
    )
  }

  function list() {
    return _.cloneDeep(accounts)
  }

  function remove(emailAddress) {
    const newaccounts = _.filter(
      accounts,
      entry => entry.emailAddress !== emailAddress
    )
    accounts = newaccounts
  }


  const api = {
    add: add,
    find: find,
    init: init,
    list: list,
    remove: remove
  }

  return api

}


const accountStore = AccountStore()
module.exports = accountStore

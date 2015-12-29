Promise = require "promise"
adminModel = require "./adminModel"
successful = require "./../../../lib/successful"

module.exports = ->
  new Promise (resolve, reject) ->
    adminModel.find {}, (err, docs) ->
      if successful err, docs
        resolve (id: doc.user, access: doc.access for doc in docs)
      else reject()

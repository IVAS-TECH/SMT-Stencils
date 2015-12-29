Promise = require "promise"
adminModel = require "./adminModel"
successful = require "./../../../lib/successful"

module.exports = (id) ->
  new Promise (resolve, reject) ->
    adminModel.findOne user: id, (err, doc) ->
      res = admin: successful err, doc
      if res.admin
        res.access = doc.access
      resolve res

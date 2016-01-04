Promise = require "promise"
adminModel = require "./adminModel"
query = require "./../../../lib/query"

module.exports = (id) ->
  new Promise (resolve, reject) ->
    adminModel.findOne user: id, (err, doc) ->
      if query.noErr err
        res = admin: doc?
        if res.admin
          res.access = doc.access
        resolve res
      else reject err

Promise = require "promise"
adminModel = require "./adminModel"
noErr = require "./../../../lib/noErr"

module.exports = (id) ->
  new Promise (resolve, reject) ->
    adminModel.findOne user: id, (err, doc) ->
      if noErr err
        res = admin: doc?
        if res.admin
          res.access = doc.access
        resolve res
      else reject err

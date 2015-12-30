adminModel = require "./adminModel"
userModel = require "./../userModel"
Promise = require "promise"
successful = require "./../../../lib/successful"

module.exports = (email, access) ->
  new Promise (resolve, reject) ->
    userModel.findOne email: email, (err, user) ->
      if not successful err, user then resolve err
      adminModel.create user: user._id, access: access, (error, doc) ->
        resolve if successful err, doc then "done" else error

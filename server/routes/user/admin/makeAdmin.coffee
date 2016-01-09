adminModel = require "./adminModel"
userModel = require "./../userModel"
Promise = require "promise"
query = require "./../../../lib/query"

module.exports = (email, access) ->

  new Promise (resolve, reject) ->

    userModel.findOne email: email, (err, user) ->

      if not query.successful err, user
        resolve err

      adminModel.create user: user._id, access: access, (error, doc) ->

        admin = "#{email} is Admin now."

        resolve if query.successful err, doc then admin else error

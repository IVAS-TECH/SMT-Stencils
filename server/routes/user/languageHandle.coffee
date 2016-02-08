userModel = require "./userModel"
query = require "./../../lib/query"
userIDParam = require "./userIDParam"

module.exports =

  get: (req, res, next) ->
    (userModel.findById req.userID)
      .exec().then ((doc) -> query res, language: doc), next

  params: get:
    name: "userID"
    callback: userIDParam

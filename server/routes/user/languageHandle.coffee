userModel = require "./userModel"
query = require "./../../lib/query"

module.exports =

  get: (req, res, next) ->
    (userModel.findById req.params.user)
      .exec().then ((doc) -> query res, language: doc), next

  params: get: "user"

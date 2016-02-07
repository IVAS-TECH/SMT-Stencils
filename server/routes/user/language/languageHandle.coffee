languageModel = require "./languageModel"
query = require "./../../../lib/query"
userIDParam = require "./../userIDParam"

module.exports =

  get: (req, res, next) ->
    (languageModel.findOne user: req.userID)
      .exec().then ((doc) -> query res, language: doc), next

  post: (req, res, next) ->
    (languageModel.update user: req.user.user, {language: req.body.language}, {upsert: no})
      .exec().then ((doc) -> query res, doc), next

  params: get:
    name: "userID"
    callback: userIDParam

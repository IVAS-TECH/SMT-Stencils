languageModel = require "./languageModel"
query = require "./../../../lib/query"

module.exports =

  get: (req, res, next) ->
    id = req.user.user
    if req.params.id isnt "id"
      id = req.params.id
    (languageModel.findOne user: id)
      .exec().then ((doc) -> query res, language: doc), next

  post: (req, res, next) ->
    (languageModel.update user: req.user.user, {language: req.body.language}, {upsert: yes})
      .exec().then ((doc) -> query res, doc), next

  params: get: "id"

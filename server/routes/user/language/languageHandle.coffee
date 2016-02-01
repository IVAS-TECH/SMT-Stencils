languageModel = require "./languageModel"
query = require "./../../../lib/query"
send = require "./../../../lib/send"

module.exports =

  get: (req, res, next) ->
    id = req.user._id
    if req.params.id isnt "id"
      id = req.params.id
    languageModel.findOne user: id, (err, doc) ->
      query.noErrHandle err, res, next, doc, "language"

  post: (req, res, next) ->
    languageModel.update user: req.user._id, {language: req.body.language}, {upsert: yes}, (err, doc) ->
      query.basicHandle err, doc, res, next

  params: get: "id"

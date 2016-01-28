languageModel = require "./languageModel"
query = require "./../../../lib/query"
send = require "./../../../lib/send"

module.exports =

  get: (req, res, next) ->
    id = req.session.get.uid
    if req.params.id isnt "id"
      id = req.params.id
    languageModel.findOne user: id, (err, doc) ->
      if query.noErr err
        language = null
        if doc?
          language = doc.language
        send res, language: language
      else next err

  post: (req, res, next) ->
    id = req.session.get.uid
    update = language: req.body.language
    languageModel.update user: id, update, {upsert: yes}, (err, doc) ->
      query.basicHandle err, doc, res, next

  params: get: "id"

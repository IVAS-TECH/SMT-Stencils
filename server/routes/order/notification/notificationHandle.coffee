descriptionModel = require "./descriptionModel"
query = require "./../../../lib/query"
send = require "./../../../lib/send"

module.exports =

  get: (req, res, next) ->
    id = req.session.get.uid
    descriptionModel.find user: id , (err, doc) ->
      query.basicHandle err, doc, res, next, "notifications"

  params: "user"

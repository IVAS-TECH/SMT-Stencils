descriptionModel = require "./descriptionModel"
query = require "./../../../lib/query"
send = require "./../../../lib/send"

module.exports =

  get: (req, res, next) ->
    descriptionModel.findOne order: req.params.order, (err, doc) ->
      query.noErrHandle err, doc, res, next, "description"

  params: "order"

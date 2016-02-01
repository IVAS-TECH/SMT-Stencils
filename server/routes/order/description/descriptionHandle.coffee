descriptionModel = require "./descriptionModel"
query = require "./../../../lib/query"

module.exports =

  get: (req, res, next) ->
    descriptionModel.findOne order: req.params.order, (err, doc) ->
      query.noErrHandle err, res, next, doc, "description"

  params: "order"

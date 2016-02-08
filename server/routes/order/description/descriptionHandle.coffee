descriptionModel = require "./descriptionModel"
query = require "./../../../lib/query"

module.exports =

  get: (req, res, next) ->
    (descriptionModel.findOne order: req.params.order)
      .exec().then ((doc) -> query res, description: doc), next

  delete: (req, res, next) ->
    (model.remove _id: req.params.order)
      .exec().then (-> query res), next

  params: "order"

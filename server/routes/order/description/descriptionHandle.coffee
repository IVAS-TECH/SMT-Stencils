descriptionModel = require "./descriptionModel"
query = require "./../../../lib/query"

module.exports =

  get: (req, res, next) ->
    (descriptionModel.findOne order: req.params.order)
      .exec().then ((doc) -> query res, description: doc), next

  params: "order"

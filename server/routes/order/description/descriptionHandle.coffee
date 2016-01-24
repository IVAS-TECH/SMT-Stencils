descriptionModel = require "./descriptionModel"
query = require "./../../../lib/query"
send = require "./../../../lib/send"

module.exports =

  get: (req, res, next) ->
    descriptionModel.findOne order: req.params.order, (err, doc) ->
      if query.noErr err
        send res, description: doc
      else next err

  params: "order"

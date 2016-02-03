visitModel = require "./visitModel"
query = require "./../../../lib/query"

module.exports =

  get: (req, res, next) ->
    ((visitModel.find {}).sort date: "desc")
      .exec().then ((docs) -> query res, visits: docs), next

visitModel = require "./visitModel"
query = require "./../../../lib/query"

module.exports =

  get: (req, res, next) ->
    visitModel
      .find {}
      .sort date: "desc"
      .exec (err, docs) ->
        query.basicHandle err, docs, res, next, "visits"

visitModel = require "./visitModel"
query = require "./../../../lib/query"

module.exports = get: (req, res, next) ->
    find = ((visitModel.find {}).sort date: "desc").exec()
    find.then ((docs) -> query res, visits: docs), next

userModel = require "./userModel"
query = require "./../../lib/query"

module.exports =
    get: (req, res, next) ->
        find = (userModel.findById req.params.user).exec()
        find.then ((doc) -> query res, language: doc), next
    params: get: "user"

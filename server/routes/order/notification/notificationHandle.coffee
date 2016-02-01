notificationModel = require "./notificationModel"
query = require "./../../../lib/query"

module.exports =

  get: (req, res, next) ->
    notificationModel.find user: req.user.user , (err, doc) ->
      query.basicHandle err, doc, res, next, "notifications"

  delete: (req, res, next) ->
    notificationModel.remove _id: req.params.id, (err) ->
      query.noErrHandle err, res, next

  params: delete: "id"

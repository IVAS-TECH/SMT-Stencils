notificationModel = require "./notificationModel"
query = require "./../../../lib/query"

module.exports =

  get: (req, res, next) ->
    (notificationModel.find user: req.user.user._id)
      .exec().then ((docs) -> query res, notifications: docs), next

  delete: (req, res, next) ->
    (notificationModel.remove _id: req.params.id)
      .exec().then (-> query res), next

  params: delete: "id"
notificationModel = require "./notificationModel"
query = require "./../../../lib/query"
send = require "./../../../lib/send"

module.exports =

  get: (req, res, next) ->
    id = req.session.get.uid
    notificationModel.find user: id , (err, doc) ->
      query.basicHandle err, doc, res, next, "notifications"

  delete: (req, res, next) ->
    notificationModel.remove _id: req.params.id, (err) ->
      if query.noErr err
        send res
      else next err

  params: delete: "id"

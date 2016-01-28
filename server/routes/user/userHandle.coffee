{join} = require "path"
send = require "./../../lib/send"
query = require "./../../lib/query"
model =
  user: require "./userModel"
  language: require "./language/languageModel"
  order: require "./../order/orderModel"
  notification: require "./../order/notification/notificationModel"
  description: require "./../order/description/descriptionModel"
  configuration: require "./../order/configuration/configurationModel"
  addresses: require "./../order/addresses/addressesModel"

module.exports =

  get: (req, res, next) ->
    model.user.findOne email: req.params.email, (err, doc) ->
      if query.noErr err
        send res, taken: doc?
      else next err

  post: (req, res, next) ->
    model.user.create req.body.user, (err, doc) ->
    query.basicHandle err, doc, res, next

  patch: (req, res, next) ->
    update = {}
    update[req.body.type] = req.body.value
    id = req.session.get.uid
    model.user.findByIdAndUpdate id, $set: update, {new: true}, (err, doc) ->
    query.basicHandle err, doc, res, next

  delete: (req, res, next) ->

  params:
    get: "email"
    delete: "id"

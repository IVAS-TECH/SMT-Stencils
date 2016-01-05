userModel = require "./userModel"
send = require "./../../lib/send"
query = require "./../../lib/query"

module.exports =

  get: (req, res, next) ->
    userModel.findOne email: req.params.email, (err, doc) ->
      if query.noErr err
        send res, taken: doc?
      else next err

  post: (req, res, next) ->
    userModel.create req.body.user, (err, doc) ->
      query.basicHandle err, doc, res, next

  patch: (req, res, next) ->
    update = {}
    update[req.body.type] = req.body.value
    id = req.session.get.uid
    userModel.findByIdAndUpdate id, $set: update, {new: true}, (err, doc) ->
      query.basicHandle err, doc, res, next

  param: "email"

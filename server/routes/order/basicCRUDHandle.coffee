send = require "./../../lib/send"
query = require "./../../lib/query"

module.exports = (model, route) ->

  get: (req, res, next) ->
    id = req.session.get.uid
    model.find user: id, (err, docs) ->
      if query.successful err, docs
        send res, "#{route}List": docs
      else next err

  post: (req, res, next) ->
    obj = req.body[route]
    obj.user = req.session.get.uid
    model.create obj, (err, doc) ->
      query.basicHandle err, doc, res, next

  patch: (req, res, next) ->
    update = req.body[route]
    id = update._id
    delete update._id
    model.findByIdAndUpdate id, $set: update, {new: true}, (err, doc) ->
      query.basicHandle err, doc, res, next

  delete: (req, res, next) ->
    model.remove _id: req.params.id, (err) ->
      if (query.noErr err)
        send res
      else next err

  params: delete: "id"

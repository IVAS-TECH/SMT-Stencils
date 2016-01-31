send = require "./../../lib/send"
query = require "./../../lib/query"

module.exports = (model, route) ->

  get: (req, res, next) ->
    id = req.session.get.uid
    model.find user: id, (err, docs) ->
      query.basicHandle err, docs, res, next, "#{route}List"

  post: (req, res, next) ->
    obj = req.body[route]
    obj.user = req.session.get.uid
    model.create obj, (err, doc) ->
      query.basicHandle err, doc, res, next

  patch: (req, res, next) ->
    update = req.body[route]
    id = update._id
    delete update._id
    model.findByIdAndUpdate id, $set: update, {new: yes}, (err, doc) ->
      query.basicHandle err, doc, res, next

  delete: (req, res, next) ->
    model.remove _id: req.params.id, (err) ->
      query.noErrHandle err, res, next

  params: delete: "id"

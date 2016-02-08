query = require "./../../lib/query"

module.exports = (model, route) ->

  get: (req, res, next) ->
    (model.find user: req.user.user._id)
      .exec().then ((docs) -> query res, "#{route}List": docs), next

  post: (req, res, next) ->
    obj = req.body[route]
    obj.user = req.user.user._id
    (model.create obj).then ((doc) -> query res, doc), next

  patch: (req, res, next) ->
    update = req.body[route]
    id = update._id
    delete update._id
    (model.findByIdAndUpdate id, $set: update, {new: yes})
      .exec().then ((doc) -> query res, doc), next

  delete: (req, res, next) ->
    (model.remove _id: req.params.id)
      .exec().then (-> query res), next

  params: delete: "id"

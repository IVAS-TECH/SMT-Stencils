adminModel = require "./adminModel"
query = require "./../../../lib/query"

module.exports = (req, res, next) ->
  if not req.user? then next()
  else
    (adminModel.findOne user: req.user.user).exec()
      .then (doc) ->
        req.admin = admin: doc?
        if req.admin.admin then req.admin.access = doc.access
        next()
      .catch next

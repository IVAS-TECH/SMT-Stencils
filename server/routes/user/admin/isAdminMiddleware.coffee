adminModel = require "./adminModel"
query = require "./../../../lib/query"

module.exports = (req, res, next) ->
  if not req.user? then next()
  else
    adminModel.findOne user: req.user._id, (err, doc) ->
      if query.noErr err
        req.admin = admin: doc?
        if req.admin.admin then req.admin.access = doc.access
        next()
      else next err

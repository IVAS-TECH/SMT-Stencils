userModel = require "./userModel"
send = require "./../../lib/send"
query = require "./../../lib/query"
isAdmin = require "./admin/isAdmin"

module.exports =

  get: (req, res, next) ->
    if not req.session.isEmpty()
      id = req.session.get.uid
      userModel.findById id, (err, doc) ->
        success = query.successful err, doc
        user = {}
        if success
          user = email: doc.email, password: doc.password
        isAdmin(id).then (admin) ->
          send res, user: user, admin: admin, login: success
    else send res, login: false, user: {}, admin: admin: false

  post: (req, res, next) ->
    userModel.findOne req.body.user, (err, doc) ->
      if query.noErr err
        if doc?
          resolve = ->
            isAdmin(doc._id).then (admin) ->
              send res, login: true, admin: admin
          req.session.create(uid: doc._id).then resolve, next
        else send res, login: false
      else next err

  delete: (req, res, next) ->
    resolve = -> send res
    req.session.destroy().then resolve, next

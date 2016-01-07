userModel = require "./userModel"
send = require "./../../lib/send"
query = require "./../../lib/query"
isAdmin = require "./admin/isAdmin"

module.exports =

  get: (req, res, next) ->
    if not req.session.isEmpty()
      id = req.session.get.uid
      userModel.findById id, (err, doc) ->
        if query.successful err, doc
          resolve = (admin) ->
            send res, login: true, user: doc, admin: admin
          isAdmin(id).then resolve, next
        else next err
    else send res, login: false, user: {}, admin: admin: false

  post: (req, res, next) ->
    userModel.findOne req.body.user, (err, doc) ->
      if query.noErr err
        if doc?
          create = ->
            resolve = (admin) ->
              send res, login: true, admin: admin
            isAdmin(doc._id).then resolve, next
          req.session.create(uid: doc._id).then create, next
        else send res, login: false
      else next err

  delete: (req, res, next) ->
    resolve = -> send res
    req.session.destroy().then resolve, next
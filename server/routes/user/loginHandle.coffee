userModel = require "./userModel"
send = require "./../../lib/send"
query = require "./../../lib/query"
visitModel = require "./visit/visitModel"
dateHelper = require "./../../share/dateHelper"
isAdminMiddleware = require "./admin/isAdminMiddleware"
sessionMiddleware = require "./../../lib/session/sessionMiddleware"
date = dateHelper.$get()

module.exports =

  get: [
    isAdminMiddleware

    (req, res, next) ->
      if not req.user?
        req.send = login: no
        next()
      else
        userModel.findById req.user.user, (err, doc) ->
          req.send = login: yes, user: doc, admin: req.admin
          next()

    (req, res, next) ->
      find = date: date.format(), ip: req.userIp
      visitModel.update find, user: req.send.login, {upsert: yes}, (err, doc) ->
        if query.successful err, doc then send res, req.send
        else next err
  ]

  post: [
    (req, res, next) ->
      userModel.findOne req.body.user, (err, doc) ->
        if query.noErr err
          req.user = doc
          next()
        else next err

    sessionMiddleware "set"

    isAdminMiddleware

    (req, res, next) -> send res, login: req.user?, admin: req.admin
  ]

  delete: sessionMiddleware "remove"

userModel = require "./userModel"
query = require "./../../lib/query"
visitModel = require "./visit/visitModel"
dateHelper = require "./../../share/dateHelper"
isAdminMiddleware = require "./admin/isAdminMiddleware"
sessionMiddleware = require "./../../lib/session/sessionMiddleware"
session = sessionMiddleware()
date = dateHelper.$get()

module.exports =

  get: [
    isAdminMiddleware

    (req, res, next) ->
      if not req.user?
        req.send = login: no
        next()
      else
        (userModel.findById req.user.user).exec()
          .then (doc) ->
            req.send = login: yes, user: doc, admin: req.admin
            next()
          .catch next

    (req, res, next) ->
      find = date: date.format(), ip: req.userIP
      (visitModel.update find, user: req.send.login, {upsert: yes})
        .exec().then (-> query res, req.send), next
  ]

  post: [
    (req, res, next) ->
      (userModel.findOne req.body.user).exec()
        .then (doc) ->
          req.user = doc
          next()
        .catch next

    session "set"

    isAdminMiddleware

    (req, res, next) -> query res, login: req.user?, admin: req.admin
  ]

  delete: session "remove"

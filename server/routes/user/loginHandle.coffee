userModel = require "./userModel"
query = require "./../../lib/query"
visitModel = require "./visit/visitModel"
dateHelper = require "./../../share/dateHelper"
sessionMiddleware = require "./../../lib/session/sessionMiddleware"
session = sessionMiddleware()
date = dateHelper.$get()

module.exports =

  get: [
    (req, res, next) ->
      if not req.user?
        req.send = login: no
        next()
      else
        (userModel.findById req.user.user._id).exec()
          .then (doc) ->
            req.send = login: yes, user: doc
            next()
          .catch next

    (req, res, next) ->
      find = date: date.format(), ip: if req.userIP? then req.userIP else req.user.ip
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

    (req, res, next) ->
      send = login: req.user?
      if send.login then send.admin = req.user.admin
      query res, send
  ]

  delete: session "remove"

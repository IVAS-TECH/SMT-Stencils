sessionModel = require "./sessionModel"
requestIp = require "request-ip"
query = require "./../query"

module.exports = (what) ->

  if what is "remove" then return (req, res, next) ->
    sessionModel.remove _id: req.user._id, (err) ->
      query.noErrHandle err, res, next

  middleware = [(req, res, next) ->
    req.userIp = requestIp.getClientIp req
    next()
  ]

  if what is "get" then middleware.push (req, res, next) ->
    console.log req.method, req.url
    sessionModel.findOne ip: req.userIp, (err, doc) ->
      if query.noErr err
        req.user = doc
        next()
      else next err

  else middleware.push (req, res, next) ->
    if not req.user? then next()
    else sessionModel.create user: req.user._id, ip: req.userIp, (err, doc) ->
      if query.successful err, doc then next()
      else next err

  middleware

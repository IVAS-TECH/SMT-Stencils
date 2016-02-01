sessionModel = require "./sessionModel"
requestIp = require "request-ip"
query = require "./../query"


module.exports = (what) ->
  middleware = [(req, res, next) ->
    req.userIp = requestIp.getClientIp req
    next()
  ]

  

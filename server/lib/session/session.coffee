Session = require "./Session"
requestIp = require "request-ip"

module.exports = ->
  (req, res, next) ->
    ip = requestIp.getClientIp req
    req.session = new Session ip
    req.session.restore().then next, next

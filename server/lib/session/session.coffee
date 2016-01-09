Session = require "./Session"
requestIp = require "request-ip"

module.exports = ->
  (req, res, next) ->
    ip = requestIp.getClientIp req
    req.session = new Session ip
    resolve = -> next()
    reject = (err) -> next err
    req.session.restore().then resolve, reject

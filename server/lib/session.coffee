Session = require "./Session"

module.exports = ->
  sessionObj = new Session()
  (req, res, next) ->
    req.ip = req.connection.remoteAddress ? req.connection._peername.address
    req.session = sessionObj
    next()

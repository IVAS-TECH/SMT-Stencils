Session = require "./Session"

module.exports = ->
  (req, res, next) ->
    req.ip = req.connection.remoteAddress ? req.connection._peername.address
    req.session = new Session req.ip
    req.session.ready().then -> next()

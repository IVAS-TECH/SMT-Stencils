Session = require "./Session"

module.exports = ->
  (req, res, next) ->
    ip = req.connection.remoteAddress ? req.connection._peername.address
    req.session = new Session ip
    resolve = -> next()
    reject = (err) -> next err
    req.session.restore().then resolve, reject

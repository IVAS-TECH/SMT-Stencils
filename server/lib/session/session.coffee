Session = require "./Session"

module.exports = ->
  (req, res, next) ->
    req.ip = req.connection.remoteAddress ? req.connection._peername.address
    req.session = new Session req.ip
    resolve = -> next()
    reject = (err) -> next err
    req.session.ready().then resolve, reject

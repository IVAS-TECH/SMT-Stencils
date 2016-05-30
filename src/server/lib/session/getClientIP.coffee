requestIp = require "request-ip"

module.exports = (req) ->
    appappengineIP = req.headers["x-appengine-user-ip"]
    if appappengineIP? then appappengineIP else requestIp.getClientIp req

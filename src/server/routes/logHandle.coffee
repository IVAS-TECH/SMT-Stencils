{join} = require "path"
sendFileMiddleware = require "./sendFileMiddleware"
sendLog = sendFileMiddleware (join __dirname, "../logs"), no

module.exports =
    get: (req, res) -> (sendLog req.params.log) req, res
    params: get: "log"

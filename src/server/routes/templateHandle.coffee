{join} = require "path"
sendFileMiddleware = require "./sendFileMiddleware"
sendTemplate = sendFileMiddleware join __dirname, "../send/templates"

module.exports =
    get: (req, res) -> (sendTemplate req.params.template) req, res
    params: get: "template"

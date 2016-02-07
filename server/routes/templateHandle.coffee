{join} = require "path"
sendFileMiddleware = require "./sendFileMiddleware"
sendTemplate = sendFileMiddleware join __dirname, "../send/templates"

module.exports =
  get: (req, res) ->
    send = sendTemplate req.params.template, yes
    send req, res

  params: get: "template"

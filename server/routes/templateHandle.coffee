sendFileMiddleware = require "./routes/sendFileMiddleware"
sendTemplate = sendFileMiddleware join __dirname, "../templates"

module.exports =
  get: (req, res) ->
    send = sendTemplate req.params.template
    send req, res

  params: get: "template"

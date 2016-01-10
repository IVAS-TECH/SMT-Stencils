{join} = require "path"
bodyParser = require "body-parser"
session = require "./lib/session/session"
errorHandler = require "./errorHandler"

sendDir = join __dirname, 'send'

sendFile = (file) ->
  (req, res) -> res.sendFile file

module.exports =

  beforeEach: [bodyParser.json(), session()]

  afterEach: [
    (req, res, next) -> next "Not Found"
    errorHandler join sendDir, "error.html"
  ]

  get: sendFile join sendDir, "index.html"

  api: require "./routes/routes"

  script:
    get: sendFile join sendDir, "bundle.js"

  "favicon.ico":
    get: sendFile join sendDir, "favicon.ico"

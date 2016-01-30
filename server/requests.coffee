{join} = require "path"
bodyParser = require "body-parser"
errorHandler = require "./errorHandler"

sendDir = join __dirname, 'send'

sendFile = (file) ->
  send = join sendDir, file
  (req, res) -> res.status(200).sendFile send

module.exports =

  beforeEach: bodyParser.json()

  afterEach: [
    (req, res, next) -> next "Not Found"
    errorHandler join sendDir, "error.html"
  ]

  get: sendFile "index.html"

  api: require "./routes/routes"

  script:
    get: sendFile "final.js"

  "favicon.ico":
    get: sendFile "favicon.ico"

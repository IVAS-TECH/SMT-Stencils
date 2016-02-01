{join} = require "path"
bodyParser = require "body-parser"
errorHandler = require "./errorHandler"

sendDir = join __dirname, 'send'

sendFile = (file, gzip = no) ->
  send = join sendDir, file
  (req, res) ->
    if gzip then res.set "Content-Encoding", "gzip"
    res.status(200).sendFile send

module.exports =

  beforeEach: bodyParser.json()

  get: sendFile "index.html", yes

  api: require "./routes/routes"

  script: get: sendFile "bundle.js"

  "favicon.ico": get: sendFile "favicon.ico"

  afterEach: [
    (req, res, next) -> next "Not Found"
    errorHandler join sendDir, "error.html"
  ]

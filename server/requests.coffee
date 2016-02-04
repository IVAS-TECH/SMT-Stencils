{join} = require "path"
{createWriteStream} = require "fs"
bodyParser = require "body-parser"
errorLogger = require "./errorLogger"
errorHandler = require "./errorHandler"

errorStream = createWriteStream (join __dirname, "error.log"), flags: "a"

sendDir = join __dirname, 'send'

sendFile = (file, gzip) ->
  send = join sendDir, file
  (req, res) ->
    if gzip then res.set "Content-Encoding", "gzip"
    res.status(200).sendFile send

module.exports =

  beforeEach: [bodyParser.json(), errorLogger errorStream]

  get: sendFile "index.html", yes

  api: require "./routes/routes"

  script: get: sendFile "final.js", yes

  "favicon.ico": get: sendFile "favicon.ico"

  afterEach: [
    (req, res, next) -> next new Error "Not Found"
    errorHandler errorStream, join sendDir, "error.html"
  ]

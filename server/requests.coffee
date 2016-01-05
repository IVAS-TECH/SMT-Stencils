{join} = require "path"
bodyParser = require "body-parser"
session = require "./lib/session/session"
errorHandler = require "./errorHandler"

appDir = join __dirname, '../client/app'
index = join appDir, "index.html"
error = join appDir, "error.html"
script = join appDir , "final.js"

sendFile = (file) ->
  (req, res) -> res.sendFile file

module.exports =
  beforeEach: [bodyParser.json(), session()]
  afterEach: [
    (req, res, next) -> next "Not Found"
    errorHandler error
  ]
  get: sendFile index
  api: require "./routes/routes"
  script:
    get: sendFile script
  "favicon.ico":
    get:  -> console.log "add favicon!!!"

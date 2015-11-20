{join} = require "path"
express = require "express"
bodyParser = require "body-parser"
serveApp = require "./lib/serveApp"
port = process.env.PORT ? 3000
app = express()
app.use bodyParser.json()
app.use serveApp join __dirname, '../client'
app.listen port, -> console.log "Server started at port : #{port}"

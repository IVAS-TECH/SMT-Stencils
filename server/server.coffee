{join} = require "path"
express = require "express"
bodyParser = require "body-parser"
mongoose = require "mongoose"
serveApp = require "./lib/serveApp"
session = require "./lib/session"
routes = require "./routes/routes"
port = process.env.PORT ? 3000
mongoose.connect "0.0.0.0:27017/db"
app = express()
app.use bodyParser.json()
app.use session()
app.use routes
app.use serveApp join __dirname, '../client'
app.listen port, -> console.log "Server started at port : #{port}"

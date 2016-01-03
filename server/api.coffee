{join} = require "path"
express = require "express"
bodyParser = require "body-parser"
session = require "./lib/session/session"
routes = require "./routes/routes"
errorHandler = require "./errorHandler"

appDir = join __dirname, '../client/app'
index = join appDir, "index.html"
error = join appDir, "error.html"
api = express()

api.use bodyParser.json()
api.use session()
api.use "/api", routes
api.get "/final.js", (req, res) -> res.sendFile join appDir , "final.js"
api.get "/favicon.ico", (req, res) -> console.log "add favicon!!!"
api.get "/", (req, res) -> res.sendFile index
api.use (req, res, next) -> next "Not Found"
api.use errorHandler error

module.exports = api

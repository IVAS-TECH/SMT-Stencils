{join} = require "path"
express = require "express"
bodyParser = require "body-parser"
mongoose = require "mongoose"
session = require "./lib/session/session"
routes = require "./routes/routes"
port = process.env.PORT ? 3000
appDir = join __dirname, '../client/app'
index = join appDir, "index.html"
error = join appDir, "error.html"
mongoose.connect "0.0.0.0:27017/db"
app = express()
app.use bodyParser.json()
app.use session()
app.use "/client", routes
app.get "/final.js", (req, res) -> res.sendFile join appDir , "final.js"
app.use (req, res) -> if req.url is "/" then res.sendFile index else res.sendFile error
app.listen port, -> console.log "Server started at port : #{port}"

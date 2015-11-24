{join} = require "path"
express = require "express"
bodyParser = require "body-parser"
mongoose = require "mongoose"
session = require "./lib/session"
routes = require "./routes/routes"
port = process.env.PORT ? 3000
appDir = join __dirname, '../client/app'
index = join appDir, "index.html"
error = join appDir, "error.html"
mongoose.connect "0.0.0.0:27017/db"
app = express()
app.use bodyParser.json()
app.use session()
app.use routes
app.get "/test/test/test", (req, res) -> res.send test: "test"
app.post "/test/register", (req, res) -> res.send user: req.body.user
app.use (req, res) -> if req.url is "/" then res.sendFile index else res.sendFile error
app.listen port, -> console.log "Server started at port : #{port}"

{join} = require "path"
express = require "express"
bodyParser = require "body-parser"
ip = require "ip"
mongoose = require "mongoose"
session = require "./lib/session/session"
routes = require "./routes/routes"

port = process.env.PORT ? 3000
address = ip.address()
appDir = join __dirname, '../client/app'
index = join appDir, "index.html"
error = join appDir, "error.html"
app = express()

mongoose.connect "#{address}:4000/db"

app.use bodyParser.json()
app.use session()
app.use "/client", routes
app.get "/final.js", (req, res) -> res.sendFile join appDir , "final.js"
app.use (req, res) -> if req.url is "/" then res.sendFile index else res.sendFile error

app.listen port, -> console.log "Server started at #{address}:#{port}"

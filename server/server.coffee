ip = require "ip"
mongoose = require "mongoose"
express = require "express"
routerTree = require "./lib/routerTree"

server = express()
server.use routerTree require "./requests"

port = process.env.PORT ? 3000
address = "0.0.0.0"#ip.address()
db = 27017

mongoose.connect "#{address}:#{db}/db"

server.listen port, -> console.log "Server started at #{address}:#{port}"

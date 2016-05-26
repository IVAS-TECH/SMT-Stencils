mongoose = require "mongoose"
express = require "express"
routerTree = require "./lib/routerTree"
defaultAdmin = require "./defaultAdmin"
server = express()
port = 8080

console.log "PORT", process.env.PORT, port

server.enable "trust proxy"

server.use routerTree require "./requests"

mongoose.connect require "./mongo"

mongoose.Promise = global.Promise

defaultAdmin()

server.listen port, -> console.log "Server started at port:#{port}"

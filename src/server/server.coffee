mongoose = require "mongoose"
express = require "express"
routerTree = require "./lib/routerTree"
defaultAdmin = require "./defaultAdmin"
mongo = require "./mongo"
server = express()
port = 8080

server.enable "trust proxy"

server.use routerTree require "./requests"
mongoose.connect "mongodb://#{mongo[process.argv[2]]}:27017/db"

mongoose.Promise = global.Promise

defaultAdmin()

server.listen port, -> console.log "Server started at port:#{port}"

mongoose = require "mongoose"
express = require "express"
routerTree = require "./lib/routerTree"
server = express()
port = process.env.PORT ? 3000

server.enable "trust proxy"

server.use routerTree require "./requests"

mongoose.connect require "./mongo"
mongoose.Promise = global.Promise

server.listen port, -> console.log "Server started at port:#{port}"

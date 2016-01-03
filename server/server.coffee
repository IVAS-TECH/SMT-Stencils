ip = require "ip"
mongoose = require "mongoose"
api = require "./api"

port = process.env.PORT ? 3000
address = "0.0.0.0"#ip.address()
db = 27017

mongoose.connect "#{address}:#{db}/db"

api.listen port, -> console.log "Server started at #{address}:#{port}"

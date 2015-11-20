mongoose = require "mongoose"

schema = new mongoose.Schema ip: String, map: mongoose.Schema.Types.ObjectId

store = mongoose.model "Session", schema

class Session
  init = ->
    map = {}
    add = (d) -> map[d.ip] = d.map
    store.find {}, (err, docs) ->
      if not err? and docs? then add doc for doc in docs
    map

  constructor: -> @map = init()

  find: (ip) -> @map[ip]

  isMapedIp: (ip) -> @map[ip]?

  mapIp: (ip, map) ->
    store.create {ip: ip, map: map}, (err, doc) ->
    @map[ip] = map

  unMapIp: (ip) ->
    store.remove ip: ip, (err, doc) ->
    delete @map[ip]

module.exports = ->
  sessionObj = new Session
  (req, res, next) ->
    req.ip = req.connection.remoteAddress ? req.connection._peername.address
    req.session = sessionObj
    next()

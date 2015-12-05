store = require "./sessionModel"

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
    @map[ip] = map
    store.create {ip: ip, map: map}, (err, doc) -> console.log err, doc

  unMapIp: (ip) ->
    store.remove ip: ip, (err, doc) ->
    delete @map[ip]

module.exports = Session

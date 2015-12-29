store = require "./sessionModel"
successful = require "./../successful"

class Session

  constructor: ->
    @map = {}
    add = (doc) => @map[doc.ip] = doc.map
    store.find {}, (err, docs) =>
      if successful err, docs
        add doc for doc in docs

  find: (ip) -> @map[ip]

  isMapedIp: (ip) -> @map[ip]?

  mapIp: (ip, map) ->
    @map[ip] = map
    store.create {ip: ip, map: map}, (err, doc) -> console.log err, doc

  unMapIp: (ip) ->
    store.remove ip: ip, (err, doc) ->
    delete @map[ip]

module.exports = Session

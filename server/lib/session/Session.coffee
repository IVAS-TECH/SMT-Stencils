Promise = require "promise"
store = require "./sessionModel"
successful = require "./../successful"

class Session

  @serializate: (value) ->
    if typeof value is "string"
      return value
    JSON.stringify value

  @deserializate: (value) -> JSON.parse value

  constructor: (@ip) ->
    @map = []
    @get = {}
    @ready = new Promise (resolve, reject) =>

      add = (doc) =>

        @get[doc.key] = Session.deserializate doc.value
        @map.push doc

      store.find ip: @ip, (err, docs) =>
        if successful err, docs
          add doc for doc in docs
          resolve()

  empty: -> @map.length is 0

  create: (map) ->
    new Promise (resolve, reject) =>
      for k, v of map
        if not @get[k]?
          create =
            ip: @ip
            key: k
            value: Session.serializate v
          store.create create, (err, doc) ->
            resolve successful err, doc
        else
          @update("#{k}": v).then (res) ->
            resolve res

  update: (map) ->
    new Promise (resolve, reject) =>
      for m in @map
        for k, v of map
          if m.key is k
            set = "#{k}": Session.serializate v
            store
              .findByIdAndUpdate m._id, $set: set, {new: true}, (err, doc) ->
                resolve successful err, doc

  delete: (map) ->
    for m in @map
      for k, v of map
        if m.key is k
          store
            .remove _id: m._id
            .exec()

  destroy: ->
    new Promise (resolve, reject) =>
      store.remove ip: @ip, (err) ->
        resolve not err?

module.exports = Session

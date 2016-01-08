Promise = require "promise"
store = require "./sessionModel"
query = require "./../query"

class Session

  constructor: (@ip) ->
    @map = []
    @get = {}

  add: (doc, index = -1) ->
    @get[doc.key] = JSON.parse doc.value
    if index is -1
      @map.push doc
    else
      @map[index] = doc

  restore: ->
    new Promise (resolve, reject) =>
      store.find ip: @ip, (err, docs) =>
        if query.successful err, docs
          @add doc for doc in docs
          resolve()
        else reject err

  isEmpty: -> @map.length is 0

  create: (map) ->
    new Promise (resolve, reject) =>
      promises = []
      for k, v of map
        if not @get[k]?
          create =
            ip: @ip
            key: k
            value: JSON.stringify v
          promises.push new Promise (qRes, qRej) =>
            store.create create, (err, doc) =>
              if query.successful err, doc
                @add doc
                qRes()
              else qRej err
        else
          promises.push @update "#{k}": v
      Promise
        .all promises
        .then resolve, reject

  update: (map) ->
    new Promise (resolve, reject) =>
      promises = []
      for m in @map
        for k, v of map
          if m.key is k
            set =
              ip: @ip
              key: k
              value: JSON.stringify v
            promises.push new Promise (qRes, qRej) =>
              store
                .findByIdAndUpdate m._id, $set: set, {new: true}, (err, doc) =>
                  if query.successful err, doc
                    @add doc, @map.indexOf m
                    qRes()
                  else qRej err
          if not @get[k]?
            promises.push @create "#{k}": v
      Promise
        .all promises
        .then resolve, reject

  remove: (key) ->
    new Promise (resolve, reject) =>
      if @isEmpty() then reject()
      else
        for m in @map
          if key is m.key
            store.remove _id: m._id, (err) =>
              if query.noErr err
                delete @get.k
                @map.splice (@map.indexOf m), 1
                resolve()
              else reject err

  delete: (key) ->
    new Promise (resolve, reject) =>
      if typeof key is "string"
        (@remove key).then resolve, reject
      else
        Promise
          .all (@remove k for k in key)
          .then resolve, reject

  destroy: ->
    new Promise (resolve, reject) =>
      store.remove ip: @ip, (err) =>
        if query.noErr err
          @map = []
          @get = {}
          resolve()
        else reject err

module.exports = Session

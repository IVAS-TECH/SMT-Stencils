Promise = require "promise"
store = require "./sessionModel"
successful = require "./../successful"

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

  ready: ->
    new Promise (resolve, reject) =>
      store.find ip: @ip, (err, docs) =>
        if successful err, docs
          @add doc for doc in docs
          resolve()
        else reject err

  isEmpty: -> @map.length is 0

  create: (map) ->
    new Promise (resolve, reject) =>
      success = true
      for k, v of map
        if not @get[k]?
          create =
            ip: @ip
            key: k
            value: JSON.stringify v
          store.create create, (err, doc) =>
            success &= successful err, doc
            if success
              @add doc
            else reject err
        else
          (@update "#{k}": v).then null, reject
      resolve()

  update: (map) ->
    new Promise (resolve, reject) =>
      success = true
      for m in @map
        for k, v of map
          if m.key is k
            set =
              ip: @ip
              key: k
              value: JSON.stringify v
            store
              .findByIdAndUpdate m._id, $set: set, {new: true}, (err, doc) =>
                success &= successful err, doc
                if success then @add doc, @map.indexOf m
                else reject err
      resolve()

  remove: (key) ->
    new Promise (resolve, reject) =>
      if @isEmpty() then reject()
      else
        for m in @map
          if key is m.key
            store.remove _id: m._id, (err) =>
              if successful err
                delete @get.k
                @map.splice (@map.indexOf m), 1
                resolve()
              else reject err

  delete: (key) ->
    new Promise (resolve, reject) =>
      success = true
      if typeof key is "string"
        (@remove key).then resolve, reject
      else
        index = 0
        next = =>
          if index < key.length
            (@remove key[index++]).then next, reject
          else resolve()
        next()

  destroy: ->
    new Promise (resolve, reject) =>
      store.remove ip: @ip, (err) =>
        if successful err
          @map = []
          @get = {}
          resolve()
        else reject err

module.exports = Session

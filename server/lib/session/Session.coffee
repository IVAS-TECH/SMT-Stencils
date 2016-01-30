Promise = require "promise"
store = require "./sessionModel"
query = require "./../query"

class Session

  constructor: (@ip) ->
    @map = []
    @get = {}

  add: (doc, index = -1) ->
    @get[doc.key] = JSON.parse doc.value
    if index is -1 then @map.push doc
    else @map[index] = doc

  restore: ->
    new Promise (resolve, reject) =>
      store.find ip: @ip, (err, docs) =>
        if query.successful err, docs
          @add doc for doc in docs
          resolve()
        else reject err

  isEmpty: -> @map.length is 0

  session: (key, value) ->
    ip: @ip
    key: key
    value: JSON.stringify value

  create: (map) ->
    new Promise (resolve, reject) =>
      promises = []
      for key, value of map
        if not @get[key]?
          promises.push new Promise (qRes, qRej) =>
            store.create (@session key, value), (err, doc) =>
              if query.successful err, doc
                @add doc
                qRes()
              else qRej err
        else promises.push @update "#{key}": value
      (Promise.all promises).then resolve, reject

  update: (map) ->
    new Promise (resolve, reject) =>
      promises = []
      for obj in @map
        for key, value of map
          if obj.key is key
            promises.push new Promise (qRes, qRej) =>
              store.findByIdAndUpdate obj._id, $set: (@session key, value), {new: true}, (err, doc) =>
                if query.successful err, doc
                  @add doc, @map.indexOf obj
                  qRes()
                else qRej err
          if not @get[key]? then promises.push @create "#{key}": value
      (Promise.all promises).then resolve, reject

  remove: (key) ->
    new Promise (resolve, reject) =>
      if @isEmpty() then reject()
      else
        for obj in @map
          if key is obj.key
            store.remove _id: obj._id, (err) =>
              if query.noErr err
                delete @get[key]
                @map.splice (@map.indexOf obj), 1
                resolve()
              else reject err

  delete: (key) ->
    new Promise (resolve, reject) =>
      if typeof key is "string" then (@remove key).then resolve, reject
      else (Promise.all (@remove k for k in key)).then resolve, reject

  destroy: ->
    new Promise (resolve, reject) =>
      store.remove ip: @ip, (err) =>
        if query.noErr err
          @map = []
          @get = {}
          resolve()
        else reject err

module.exports = Session

requestIp = require "request-ip"
userModel = require "./userModel"
send = require "./../../lib/send"
query = require "./../../lib/query"
isAdmin = require "./admin/isAdmin"
visitModel = require "./visit/visitModel"
dateHelper = require "./../../share/dateHelper"
date = dateHelper.$get()

module.exports =

  get: (req, res, next) ->
    find =
      ip: requestIp.getClientIp req
      date: date.format()
    updateVisits = (user, callback) ->
      visitModel.update find, user: user, {upsert: yes}, (err, doc) ->
        if query.successful err, doc
          callback()
        else next err
    if not req.session.isEmpty()
      updateVisits yes, ->
        id = req.session.get.uid
        userModel.findById id, (err, doc) ->
          if query.successful err, doc
            resolve = (admin) ->
              send res, login: yes, user: doc, admin: admin
            isAdmin(id).then resolve, next
          else next err
    else updateVisits no, -> send res, login: no

  post: (req, res, next) ->
    userModel.findOne req.body.user, (err, doc) ->
      if query.noErr err
        if doc?
          create = ->
            resolve = (admin) ->
              send res, login: yes, admin: admin
            isAdmin(doc._id).then resolve, next
          req.session.create(uid: doc._id).then create, next
        else send res, login: no
      else next err

  delete: (req, res, next) ->
    resolve = -> send res
    req.session.destroy().then resolve, next

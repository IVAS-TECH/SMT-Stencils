sessionModel = require "./sessionModel"
requestIp = require "request-ip"
query = require "./../query"

module.exports = (field = "user") ->

  (middleware) ->

    switch middleware

      when "remove" then return (req, res, next) ->
        (sessionModel.remove _id: req[field]._id)
          .exec().then (-> query res), next

      when "get" then return (req, res, next) ->
          ip = requestIp.getClientIp req
          (sessionModel.findOne ip: ip)
            .populate "user"
            .exec()
            .then (doc) ->
              req[field] = doc
              if not doc? then req.userIP = ip
              next()
            .catch next

      when "set" then return (req, res, next) ->
        if not req.user? then next()
        else
          ip = requestIp.getClientIp req
          user = req[field]
          (sessionModel.create user: user._id, ip: ip)
            .then (doc) ->
              req[field] = user: user, ip: ip, _id: doc._id
              next()
            .catch next

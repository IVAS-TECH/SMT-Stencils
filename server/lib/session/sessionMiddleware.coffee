sessionModel = require "./sessionModel"
requestIp = require "request-ip"
query = require "./../query"

module.exports = (field = "user", ipField = "userIp") ->

  setIp = (req) -> req[ipField] = requestIp.getClientIp req

  action = (req, next) ->
    (doc) ->
      req[field] = doc
      next()

  (middleware) ->

    switch middleware

      when "remove" then return (req, res, next) ->
        (sessionModel.remove _id: req[field]._id)
          .exec().then (-> query res), next

      when "get" then return (req, res, next) ->
          console.log req.method, req.url
          setIp req
          (sessionModel.findOne ip: req[ipField])
            .exec().then (action req, next), next

      when "set" then return (req, res, next) ->
        setIp req
        if not req.user? then next()
        else
          (sessionModel.create user: req[field]._id, ip: req[ipField])
            .then (action req, next), next

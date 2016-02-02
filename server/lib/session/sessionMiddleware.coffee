sessionModel = require "./sessionModel"
requestIp = require "request-ip"
query = require "./../query"

module.exports = (field = "user", ipField = "userIp") ->

  setIp = (req) -> req[ipField] = requestIp.getClientIp req

  (middleware) ->

    switch middleware

      when "remove" then return (req, res, next) ->
        sessionModel.remove _id: req[field]._id, (err) ->
          query.noErrHandle err, res, next

      when "get" then return (req, res, next) ->
          console.log req.method, req.url
          setIp req
          sessionModel.findOne ip: req[ipField], (err, doc) ->
            if query.noErr err
              req[field] = doc
              next()
            else next err

      when "set" then return (req, res, next) ->
        setIp req
        if not req.user? then next()
        else sessionModel.create user: req[field]._id, ip: req[ipField], (err, doc) ->
          if query.successful err, doc
            req[field] = doc
            next()
          else next err

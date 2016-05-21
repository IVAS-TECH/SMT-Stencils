sessionModel = require "./sessionModel"
requestIp = require "request-ip"
query = require "./../query"

module.exports = (field = "user") ->
    field: field
    remove: (req, res, next) -> (sessionModel.remove _id: req[field]._id).exec().then (-> query res), next
    get: (req, res, next) ->
        ip = requestIp.getClientIp req
        find = ((sessionModel.findOne ip: ip).populate "user").exec()
        find.then ((doc) ->
            req[field] = doc
            if not doc? then req[field + "IP"] = ip
            next()
        ), next
    set: (req, res, next) ->
        if not req[field]? then next()
        else
            ip = requestIp.getClientIp req
            user = req[field]
            (sessionModel.create user: user._id, ip: ip).then ((doc) ->
                req[field] = user: user, ip: ip, _id: doc._id
                next()
            ), next

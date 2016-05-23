userModel = require "./userModel"
query = require "./../../lib/query"
visitModel = require "./visit/visitModel"
dateHelper = require "./../../share/dateHelper"
sessionMiddleware = require "./../../lib/session/sessionMiddleware"
session = sessionMiddleware()
date = dateHelper.$get()

module.exports =
    get: [
        (req, res, next) ->
            req.send = login: req.user?
            if req.send.login
                (userModel.findById req.user.user._id).exec().then ((doc) ->
                    req.send.user = doc
                    next()
                ), next
            else next()

        (req, res, next) ->
            find = date: date.format(), ip: if req.userIP? then req.userIP else req.user.ip
            update = (visitModel.update find, user: req.send.login, {upsert: yes})
            update.exec().then (-> query res, req.send), next
    ]
    post: [
        (req, res, next) ->
            (userModel.findOne req.body.user).exec().then ((doc) ->
                req.user = doc
                next()
            ), next

        session.set

        (req, res) ->
            login = req.user?
            query res, login: login, user: if login then req.user.user else req.user
    ]
    delete: session.remove

{join} = require "path"
orderModel = require "./orderModel"
isAdmin = require "./../user/admin/isAdmin"
GerberToSVG = require "./../../lib/GerberToSVG"
query = require "./../../lib/query"
send = require "./../../lib/send"
block = (uid) -> null

dir = join __dirname, "../../../files"

filePath = (f) -> join dir, f

module.exports =

  post: (req, res, next) ->
    order = req.body.order
    order.user = req.session.get.uid
    orderModel.create order, (err, doc) ->
      query.basicHandle err, doc, res, next

  get: (req, res, next) ->
    id = req.session.get.uid
    isAdmin(id).then (admin) ->
      find = user: id
      if admin.admin
        find = {}
      orderModel.find find, (err, docs) ->
        if query.successful err, docs
          send res, orders: docs
        else next err

  put: (req, res, next) ->

    files = (filePath file for file in req.body.files)

    GerberToSVG(files).then (svg) ->
      send res, svg

  patch: ->

  delete: ->

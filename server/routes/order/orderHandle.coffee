{join} = require "path"
orderModel = require "./orderModel"
isAdmin = require "./../user/admin/isAdmin"
GerberToSVG = require "./../../lib/GerberToSVG/GerberToSVG"
query = require "./../../lib/query"
send = require "./../../lib/send"
block = (uid) -> null

dir = join __dirname, "../../../files"

filePaths = (files) ->
  paths = {}
  for layer, file of files
    paths[layer] = join dir, file
  paths

module.exports =

  download:

    get: (req, res, next) ->
      res.status(200).sendFile join dir, req.params.file

    params: "file"

  post: (req, res, next) ->
    order = req.body.order
    order.user = req.session.get.uid
    orderModel.create order, (err, doc) ->
      query.basicHandle err, doc, res, next

  get: (req, res, next) ->
    id = req.session.get.uid

    resolve = (admin) ->
      find = user: id
      if admin.admin
        find = {}
      orderModel
        .find find
        .populate "user"
        .sort orderDate: "desc"
        .exec (err, docs) ->
          if query.successful err, docs
            send res, orders: docs
          else next err

    isAdmin(id).then resolve, next

  put: (req, res, next) ->
    id = req.session.get.uid

    resolve = (admin) ->
      (GerberToSVG (filePaths req.body.files), admin.admin).then (svg) ->
        send res, svg

    isAdmin(id).then resolve, next

  patch: ->

  delete: ->

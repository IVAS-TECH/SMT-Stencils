{join} = require "path"
orderModel = require "./orderModel"
isAdminMiddleware = require "./../user/admin/isAdminMiddleware"
basicCRUDHandle = require "./basicCRUDHandle"
GerberToSVG = require "./../../lib/GerberToSVG/GerberToSVG"
descriptionModel = require "./description/descriptionModel"
notificationModel = require "./notification/notificationModel"
resolveDescriptionBindings = require "./description/resolveDescriptionBindings"
getDescriptionTemplate = require "./description/getDescriptionTemplate"
query = require "./../../lib/query"
send = require "./../../lib/send"

dir = join __dirname, "../../../files"

filePaths = (files) ->
  paths = {}
  for layer, file of files
    paths[layer] = join dir, file
  paths

handle = basicCRUDHandle orderModel, "order"

handle.download =

    get: (req, res, next) ->
      res.status(200).sendFile join dir, req.params.file

    params: "file"

handle.get = [
  isAdminMiddleware

  (req, res, next) ->
    find = if req.admin.admin then user: req.user._id else {}
    orderModel
      .find find
      .populate "user"
      .sort orderDate: "desc"
      .exec (err, docs) ->
        query.basicHandle err, docs, res, next, "orders"
]

handle.put = [
  isAdminMiddleware

  (req, res, next) ->
    (GerberToSVG (filePaths req.body.files), req.admin.admin).then ((svg) -> send res, svg), next
]

handle.patch = [
  (req, res, next) ->

    text = req.body.text

    order = status: req.body.status

    if req.body.price?
      order.price = req.body.price

    if order.status is "sent"
      order.sendingDate = new Date()

    orderModel.findByIdAndUpdate req.body.id, $set: order, {new: true}, (err, doc) ->

      if query.successful err, doc
        if text[0] is ""
          (getDescriptionTemplate order.status, req.body.language).then (txt) ->
            req.text = txt
            next()
        else
          req.text = text
          next()
      else next err

  (req, res, next) ->
    binded = resolveDescriptionBindings req.text, req.body
    descriptionModel.update order: req.body.id, {text: binded}, {upsert: yes}, (err, doc) ->
      if query.successful err, doc then next()
      else next err

  (req, res, next) ->
    notificationModel.create order: req.body.id, user: req.body.user, (err, doc) ->
      query.basicHandle err, doc, res, next
]

module.exports = handle

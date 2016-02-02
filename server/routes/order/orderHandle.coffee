{join} = require "path"
orderModel = require "./orderModel"
isAdminMiddleware = require "./../user/admin/isAdminMiddleware"
basicCRUDHandle = require "./basicCRUDHandle"
descriptionModel = require "./description/descriptionModel"
notificationModel = require "./notification/notificationModel"
GerberToSVGMiddleware = require "./../../lib/GerberToSVG/GerberToSVGMiddleware"
resolveDescriptionBindings = require "./description/resolveDescriptionBindings"
getDescriptionTemplate = require "./description/getDescriptionTemplate"
query = require "./../../lib/query"
send = require "./../../lib/send"

dir = join __dirname, "../../../files"

handle = basicCRUDHandle orderModel, "order"

handle.download =

    get: (req, res, next) ->
      res.status(200).sendFile join dir, req.params.file

    params: "file"

handle.get = [
  isAdminMiddleware

  (req, res, next) ->
    find = user: req.user.user
    if req.admin.admin then find = {}
    orderModel
      .find find
      .populate "user"
      .sort orderDate: "desc"
      .exec (err, docs) ->
        query.basicHandle err, docs, res, next, "orders"
]

handle.put = [
  (req, res, next) ->
    req.gerbers = {}
    for layer, file of req.body.files
      req.gerbers[layer] = join dir, file
    next()

  GerberToSVGMiddleware "top"

  GerberToSVGMiddleware "bottom"

  GerberToSVGMiddleware "send"
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

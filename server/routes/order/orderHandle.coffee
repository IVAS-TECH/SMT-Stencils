{join} = require "path"
orderModel = require "./orderModel"
basicCRUDHandle = require "./basicCRUDHandle"
descriptionModel = require "./description/descriptionModel"
notificationModel = require "./notification/notificationModel"
GerberToSVGMiddleware = require "./../../lib/GerberToSVG/GerberToSVGMiddleware"
resolveDescriptionBindings = require "./description/resolveDescriptionBindings"
getDescriptionTemplate = require "./description/getDescriptionTemplate"
query = require "./../../lib/query"

dir = join __dirname, "../../../files"

handle = basicCRUDHandle orderModel, "order"

handle.download =

    get: (req, res, next) ->
      (res.status 200).sendFile join dir, req.params.file

    params: "file"

handle.get = (req, res, next) ->
    find = if req.user.user.admin then find = {} else user: req.user.user._id
    (((orderModel.find find).populate "user").sort orderDate: "desc")
      .exec().then ((docs) -> query res, orders: docs), next

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

    (orderModel.findByIdAndUpdate req.body.id, $set: order, {new: true}).exec()
      .then (doc) ->

        if text[0] is ""
          (getDescriptionTemplate order.status, req.body.language).then (txt) ->
            req.text = txt
            next()
        else
          req.text = text
          next()
      .catch next

  (req, res, next) ->
    binded = resolveDescriptionBindings req.text, req.body
    (descriptionModel.update order: req.body.id, {text: binded}, {upsert: yes})
      .exec().then (-> next()), next

  (req, res, next) ->
    (notificationModel.create order: req.body.id, user: req.body.user)
      .then ((doc) -> query res, doc), next
]

module.exports = handle

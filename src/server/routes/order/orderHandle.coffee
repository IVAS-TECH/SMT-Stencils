{join} = require "path"
orderModel = require "./orderModel"
basicCRUDHandle = require "./basicCRUDHandle"
descriptionModel = require "./description/descriptionModel"
notificationModel = require "./notification/notificationModel"
GerberToSVGMiddleware = require "./../../lib/GerberToSVG/GerberToSVGMiddleware"
resolveDescriptionBindings = require "./description/resolveDescriptionBindings"
getDescriptionTemplate = require "./description/getDescriptionTemplate"
sendFileHandle = require "./../sendFileHandle"
query = require "./../../lib/query"
tryCleanGerber = require "./file/tryCleanGerber"

dir = join __dirname, "./../../files"
layers = ["top", "bottom", "outline"]
handle = basicCRUDHandle orderModel, "order"

gerbersMiddleware = (getGerbers) -> (req, res, next) ->
    getGerbers req, res, next, (data) ->
        req.gerbers = {}
        (if data[layer]? then req.gerbers[layer] = join dir, data[layer]) for layer in layers
        next()

handle.download = sendFileHandle dir, yes

handle.get = (req, res, next) ->
    find = if req.user.user.admin then find = {} else user: req.user.user._id
    find = ((orderModel.find find).populate "user").sort orderDate: "desc"
    find.exec().then ((docs) -> query res, orders: docs), next

handle.put = [
    gerbersMiddleware (req, res, next, callback) -> callback req.body.files
    (req, res, next) ->
        {files} = req.body
        storage = req.fileStorage
        if not storage? then next()
        else
            download = (layer) -> new Promise (resolve, reject) ->
                (storage.file files[layer]).download destination: req.gerbers[layer], (err) ->
                    if err then reject err else resolve()
            promises = ((if files[layer]? then download layer) for layer in layers)
            (Promise.all promises).then (-> next()), next
    GerberToSVGMiddleware "top"
    GerberToSVGMiddleware "bottom"
    GerberToSVGMiddleware "send"
]

handle.patch = [
    (req, res, next) ->
        text = req.body.text
        order = status: req.body.status
        if req.body.price? then order.price = req.body.price
        if order.status is "sent" then order.sendingDate = new Date()
        (orderModel.findByIdAndUpdate req.body.id, $set: order, {new: yes}).exec().then ((doc) ->
            if text[0] is ""
                (getDescriptionTemplate order.status, req.body.language).then ((txt) ->
                    req.text = txt
                    next()
                ), next
            else
                req.text = text
                next()
        ), next
    (req, res, next) ->
        binded = resolveDescriptionBindings req.text, req.body
        (descriptionModel.update order: req.body.id, {text: binded}, {upsert: yes}).exec().then (-> next()), next
    (req, res, next) ->
        (notificationModel.create order: req.body.id, user: req.body.user).then ((doc) -> query res, doc), next
]

removeOrderRelation = (model) -> (req, res, next) ->
    (model.remove order: req.params.id).exec().then (-> next()), next

deleteHandle = handle.delete
delete handle.delete
handle.delete = [
    gerbersMiddleware (req, res, next, callback) ->
        orderModel.findById req.params.id, (err, order) ->
            if err then next err else callback order.files
]
handle.delete.push tryCleanGerber layer, yes for layer in layers
handle.delete.push removeOrderRelation model for model in [notificationModel, descriptionModel]
handle.delete.push deleteHandle

module.exports = handle

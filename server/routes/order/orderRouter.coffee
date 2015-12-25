{Router} = require "express"
file = require "./file/fileRouter"
config = require "./config/configRouter"
addresses = require "./addresses/addressesRouter"
orderModel = require "./orderModel"
router = new Router()

successful = (err, doc) -> doc? and not err?

router.use "/file", file
router.use config
router.use addresses

router.post "/order", (req, res) ->
  orderModel.create req.body.order, (err, doc) ->
    res.send  doc: doc, success: successful err, doc

router.get "/order", (req, res) ->
  id = req.session.find req.ip
  orderModel.find "configuration.user": id, (err, docs) ->
    success = successful err, docs
    response = success: success
    if success then response.orders = docs
    res.send response

module.exports = router

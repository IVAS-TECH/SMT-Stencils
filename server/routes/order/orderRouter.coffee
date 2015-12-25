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

module.exports = router

{Router} = require "express"
{join} = require "path"
file = require "./file/fileRouter"
config = require "./config/configRouter"
addresses = require "./addresses/addressesRouter"
orderModel = require "./orderModel"
GerberToSVG = require "./../../lib/GerberToSVG"
router = new Router()

successful = (err, doc) -> doc? and not err?

router.use "/file", file
router.use config
router.use addresses

router.post "/order", (req, res) ->
  order = req.body.order
  order.user = req.session.find req.ip
  orderModel.create order, (err, doc) ->
    res.send  doc: doc, success: successful err, doc

router.get "/order", (req, res) ->
  id = req.session.find req.ip
  orderModel.find user: id, (err, docs) ->
    success = successful err, docs
    response = success: success
    if success then response.orders = docs
    res.send response

router.put "/order", (req, res) ->
  dir = join __dirname, "../../../files"

  filePath = (f) -> join dir, f

  files = (filePath file for file in req.body.files)

  GerberToSVG(files).then (svg) ->
    res.send svg

module.exports = router

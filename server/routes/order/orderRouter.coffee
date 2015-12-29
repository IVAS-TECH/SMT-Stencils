{Router} = require "express"
{join} = require "path"
file = require "./file/fileRouter"
config = require "./config/configRouter"
addresses = require "./addresses/addressesRouter"
orderModel = require "./orderModel"
isAdmin = require "./../user/admin/isAdmin"
GerberToSVG = require "./../../lib/GerberToSVG"
successful = require "./../../lib/successful"
router = new Router()

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
  isAdmin(id).then (admin) ->
    find = if admin.admin then {} else user: id
    orderModel.find find, (err, docs) ->
      success = successful err, docs
      response = success: success
      if success then response.orders = docs
      res.send response

router.put "/order", (req, res) ->
  dir = join __dirname, "../../../files"

  filePath = (f) -> join dir, f

  files = (filePath file for file in req.body.files)

  GerberToSVG(files).then (svg) ->
    svg.success = true
    res.send svg

module.exports = router

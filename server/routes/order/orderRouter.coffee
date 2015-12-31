{Router} = require "express"
{join} = require "path"
file = require "./file/fileRouter"
config = require "./config/configRouter"
addresses = require "./addresses/addressesRouter"
orderModel = require "./orderModel"
isAdmin = require "./../user/admin/isAdmin"
GerberToSVG = require "./../../lib/GerberToSVG"
successful = require "./../../lib/successful"
block = (ip) -> null
dir = join __dirname, "../../../files"

filePath = (f) -> join dir, f

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

  files = (filePath file for file in req.body.files)

  GerberToSVG(files).then (svg) -> res.send svg

router.patch "/order", (req, res) ->
  order = req.body.order
  action = 0

  delete order.sendingDate

  switch order.status
    when "__new__"
      action = 0
    when "__accepted__"
      action = 0
    when "__rejected__"
      action = 0
    when "__done__"
      action = 0
    when "__sent__"
      order.sendingDate = Date.now()
    when "__delivered__"
      action = 0
    when "__$remove$__"
      action = 1
    when "__$delete$__"
      action = 2
    when "__$block$__"
      action = 3

  if action
    fs = require "fs"
    success = false

    send = -> res.send success: success

    for file in order.files
      fs.unlink filePath file, ->

    orderModel.remove _id: order._id, (orderErr) ->
      err = (e) -> success |= orderErr is null

      err orderErr

      if action > 1
        configModel = require "./config/configModel"
        addressesModel = require "./addresses/addressesModel"
        userModel = require "./../user/userModel"
        user = user: order.user

        configModel.remove user, (configErr) ->
          err configErr
          addressesModel.remove user, (addressesErr) ->
            err addressesErr
            userModel.remove _id: user.user, (userErr) ->
              err userErr
              if action > 2
                block(req.ip).then (blcokErr) ->
                  err blockErr
                  send()
              else send()
      else send()

  else
    id = order._id
    delete order._id
    orderModel.findByIdAndUpdate id, $set: order, {new: true}, (err, doc) ->
      res.send success: successful err, doc

module.exports = router

{Router} = require "express"
userModel = require "./userModel"
router = new Router()

successful = (err, doc) -> doc? and not err?

router.get "/user/:email", (req, res) ->
  userModel.findOne email: req.params.email, (err, doc) ->
    res.send taken: successful err, doc

router.post "/user", (req, res) ->
  userModel.create req.body.user, (err, doc) ->
    res.send success: successful err, doc

router.patch "/user", (req, res) ->
  update = {}
  update[req.body.type] = req.body.value
  userModel.findByIdAndUpdate req.session.find req.ip, $set: update, (err, doc) ->
    res.send success: successful err, doc

router.get "/login", (req, res) ->
  status = req.session.isMapedIp req.ip
  userModel.findById req.session.find req.ip, (err, doc) ->
    user = {}
    if status then user = email: doc.email, password: doc.password
    res.send user: user, success: status

router.post "/login", (req, res) ->
  userModel.findOne req.body.user, (err, doc) ->
    success = successful err, doc
    if success then req.session.mapIp req.ip, doc._id
    res.send success: success

router.delete "/login", (req, res) ->
  req.session.unMapIp req.ip
  res.send success: true

module.exports = router

{Router} = require "express"
userModel = require "./userModel"
router = new Router()

successful = (err, doc) -> doc? and not err?

router.get "/user/:email", (req, res) -> userModel.findOne email: req.params.email, (err, doc) -> res.send exist: successful err, doc

router.post "/user", (req, res) -> userModel.create req.body.user, (err, doc) -> res.send success: successful err, doc

router.patch "/user", (req, res) ->
  update = {}
  id = req.session.find req.ip
  update[req.body.type] = req.body.value
  userModel.findByIdAndUpdate id, $set: update, (err, doc) ->
    res.send success: successful err, doc

router.get "/login", (req, res) ->
  status = req.session.isMapedIp req.ip
  id = req.session.find req.ip
  if status
    userModel.findById id, (err, doc) ->
      res.send user: {email: doc.email, password: doc.password}, success: status

router.post "/login", (req, res) ->
  userModel.findOne req.body.user, (err, doc) ->
    success = successful err, doc
    if success and req.body.session then req.session.mapIp req.ip, doc._id
    res.send success: success

router.delete "/login", (req, res) -> req.session.unMapIp req.ip

module.exports = router

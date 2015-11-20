{Router} = require "express"
userModel = require "./userModel"
router = new Router()

router.get "/email/:email", (req, res) ->
  userModel.findOne email: req.params.email, (err, doc) -> res.send exist: doc? and not err?

router.post "/register", (req, res) ->
  userModel.create req.body.user, (err, doc) -> res.send success: not err?

router.get "/login", (req, res) ->
  status = req.session.isMapedIp req.ip
  id = req.session.find req.ip
  if status
    userModel.findById id, (err, doc) ->
      res.send user: {email: doc.email, password: doc.password}, success: status

router.post "/login", (req, res) ->
  userModel.findOne req.body.user, (err, doc) ->
    success = doc? and not err?
    if success and req.body.session then req.session.mapIp req.ip, doc._id
    res.send success: success

router.get "/logout", (req, res) ->
  req.session.unMapIp req.ip

module.exports = router

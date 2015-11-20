{Router} = require "express"
userModel = require "./userModel"
router = new Router()

router.get "/email/:email", (req, res) ->
  userModel.findOne email: req.params.email, (err, doc) -> res.send exist: doc? and not err?

router.post "/register", (req, res) ->
  userModel.create req.body.user, (err, doc) -> res.send success: not err?

router.get "/login", (req, res) -> res.send user: {email: "ivo", password: "ivo"}, success: true

router.post "/login", (req, res) ->
  userModel.findOne req.body.user, (err, doc) -> res.send success: doc? and not err?

router.get "/logout", (req, res) ->
  req.session.unMapIp req.ip


module.exports = router

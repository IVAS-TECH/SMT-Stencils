{Router} = require "express"
model = require "./userModel"
router = new Router()
router.post "/register", (req, res) ->
  model.create req.body.user, (err, doc) -> res.send success: not err?

module.exports = router

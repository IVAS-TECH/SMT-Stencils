{Router} = require "express"
configModel = require "./configModel"
router = new Router()

router.post "/config", (req, res) ->
  config = req.body.config
  config.user = req.session.find req.ip
  configModel.create config, (err, doc) ->
    res.send success: doc? and not err?

module.exports = router

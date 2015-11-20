{Router} = require "express"
configModel = require "./configModel"
router = new Router()

router.post "/config", (req, res) ->
  configModel.create req.body.config, (err, doc) ->
    console.log err, doc
    res.send success: doc? and not err?

module.exports = router

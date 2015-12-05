{Router} = require "express"
configModel = require "./configModel"
router = new Router()

successful = (err, doc) -> doc? and not err?

router.post "/config", (req, res) ->
  config = req.body.config
  config.user = req.session.find req.ip
  configModel.create config, (err, doc) ->
    success = successful err, doc
    response = success: success
    if success then response._id = doc._id
    res.send response

router.get "/config", (req, res) ->
  id = req.session.find req.ip
  configModel
    .find user: id
    .populate "user"
    .exec (err, doc) ->
      success = successful err, doc
      response = success: success
      if success then response.configs = doc
      res.send response

module.exports = router

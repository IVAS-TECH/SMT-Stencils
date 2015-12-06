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

router.patch "/config", (req, res) ->
  config = req.body.config
  id = config._id
  delete config._id
  configModel.findByIdAndUpdate id, $set: config, (err, doc, result) ->
    res.send success: successful err, result

router.delete "/config/:id", (req, res) ->
  configModel.remove _id: req.params.id, (err) ->
    res.send success: err is null

module.exports = router

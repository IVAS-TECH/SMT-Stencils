{Router} = require "express"
addressesModel = require "./addressesModel"
router = new Router()

successful = (err, doc) -> doc? and not err?

router.post "/addresses", (req, res) ->
  addresses = req.body.addresses
  addresses.user = req.session.find req.ip
  addressesModel.create addresses, (err, doc) ->
    success = successful err, doc
    response = success: success, user: addresses.user
    if success then response._id = doc._id
    res.send response

router.get "/addresses", (req, res) ->
  id = req.session.find req.ip
  addressesModel
    .find user: id, (err, doc) ->
      success = successful err, doc
      response = success: success
      if success then response.addresses = doc
      res.send response

router.patch "/addresses", (req, res) ->
  addresses = req.body.addresses
  id = addresses._id
  delete addresses._id
  addressesModel.findByIdAndUpdate id, $set: addresses, {new: true}, (err, doc) ->
    res.send success: successful err, doc

router.delete "/addresses/:id", (req, res) ->
  addressesModel.remove _id: req.params.id, (err) ->
    res.send success: err is null

module.exports = router

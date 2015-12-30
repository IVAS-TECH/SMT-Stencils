{Router} = require "express"
userModel = require "./userModel"
successful = require "./../../lib/successful"
isAdmin = require "./admin/isAdmin"
router = new Router()

router.get "/user/:email", (req, res) ->
  userModel.findOne email: req.params.email, (err, doc) ->
    res.send success: true, taken: successful err, doc

router.post "/user", (req, res) ->
  userModel.create req.body.user, (err, doc) ->
    res.send success: successful err, doc

router.patch "/user", (req, res) ->
  update = {}
  update[req.body.type] = req.body.value
  id = req.session.find req.ip
  userModel.findByIdAndUpdate id, $set: update, {new: true}, (err, doc) ->
    res.send success: successful err, doc

router.get "/login", (req, res) ->
  status = req.session.isMapedIp req.ip
  if status
    id = req.session.find req.ip
    userModel.findById id, (err, doc) ->
      user = {}
      success = status and successful err, doc
      if success then user = email: doc.email, password: doc.password else {}
      isAdmin(id).then (admin) ->
        res.send user: user, success: success, admin: admin, login: success
  else res.send login: false, success: true, user: {}, admin: admin:false

router.post "/login", (req, res) ->
  userModel.findOne req.body.user, (err, doc) ->
    success = successful err, doc
    if success then req.session.mapIp req.ip, doc._id
    isAdmin(doc._id).then (admin) ->
      res.send success: true, login: success, admin: admin

router.delete "/login", (req, res) ->
  req.session.unMapIp req.ip
  res.send success: true

module.exports = router

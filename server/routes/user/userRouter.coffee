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
  if not req.session.empty()
    id = req.session.get.uid
    userModel.findById id, (err, doc) ->
      success = successful err, doc
      user = if success then email: doc.email, password: doc.password else {}
      isAdmin(id).then (admin) ->
        res.send user: user, success: true, admin: admin, login: success
  else res.send login: false, success: true, user: {}, admin: admin: false

router.post "/login", (req, res) ->
  userModel.findOne req.body.user, (err, doc) ->
    if successful err, doc
      req.session.create(uid: doc._id).then (login) ->
        isAdmin(doc._id).then (admin) ->
          res.send success: true, login: login, admin: admin
    else res.send success: false

router.delete "/login", (req, res) ->
  req.session.destroy().then (success) ->
    res.send success: success

module.exports = router

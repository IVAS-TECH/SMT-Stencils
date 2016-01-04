{Router} = require "express"
userModel = require "./userModel"
send = require "./../../lib/send"
query = require "./../../lib/query"
isAdmin = require "./admin/isAdmin"
router = new Router()

router.get "/user/:email", (req, res, next) ->
  userModel.findOne email: req.params.email, (err, doc) ->
    if query.noErr err
      send res, taken: doc?
    else next err

router.post "/user", (req, res, next) ->
  userModel.create req.body.user, (err, doc) ->
    query.basicHandle err, doc, res, next

router.patch "/user", (req, res, next) ->
  update = {}
  update[req.body.type] = req.body.value
  id = req.session.get.uid
  userModel.findByIdAndUpdate id, $set: update, {new: true}, (err, doc) ->
    query.basicHandle err, doc, res, next

router.get "/login", (req, res, next) ->
  if not req.session.isEmpty()
    id = req.session.get.uid
    userModel.findById id, (err, doc) ->
      success = query.successful err, doc
      user = if success then email: doc.email, password: doc.password else {}
      isAdmin(id).then (admin) ->
        send res, user: user, admin: admin, login: success
  else send res, login: false, user: {}, admin: admin: false

router.post "/login", (req, res, next) ->
  userModel.findOne req.body.user, (err, doc) ->
    if query.noErr err
      if doc?
        resolve = ->
          isAdmin(doc._id).then (admin) ->
            send res, login: true, admin: admin
        req.session.create(uid: doc._id).then resolve, next
      else send res, login: false
    else next err

router.delete "/login", (req, res, next) ->
  resolve = -> send res
  req.session.destroy().then resolve, next

module.exports = router

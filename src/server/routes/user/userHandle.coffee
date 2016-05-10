fs = require "fs"
{join} = require "path"
userModel = require "./userModel"
query = require "./../../lib/query"
userIDParam = require "./userIDParam"
models = [
  require "./../order/orderModel"
  require "./../order/notification/notificationModel"
  require "./../order/description/descriptionModel"
  require "./../order/configuration/configurationModel"
  require "./../order/addresses/addressesModel"
]

files = join __dirname, "./../../files"

wipeFromCollection = (collection) ->
  (req, res, next) ->
    (collection.remove user: req.userID).exec().then ( -> next()), next

wipeFromDB = [
  (req, res, next) ->
    req.deletes = []
    check = (p) -> typeof p is "string" and p.length and p not in req.deletes
    (models[0].find user: req.userID).exec()
      .then (docs) ->
        for doc in docs
          for layer in ["top", "bottom", "outline"]
            path = doc.files[layer]
            if check path then req.deletes.push path
        next()
      .catch next
]

wipeFromDB.push wipeFromCollection model for model in models

wipeFromDB.push (req, res, next) ->
  (userModel.remove _id: req.userID).exec().then (-> next()), next

wipeFromDB.push (req, res, next) ->
  deleted = (for file in req.deletes
    new Promise (resolve, reject) ->
      fs.unlink (join files, file), (err) ->
        if err then reject err else resolve())
  (Promise.all deleted).then (-> query res), next

module.exports =

  get: (req, res, next) ->
    ((userModel.find {}).sort admin: "desc")
      .exec().then ((docs) -> query res, users: docs), next

  post: (req, res, next) ->
    (userModel.create req.body.user).then ((doc) -> query res, doc), next

  patch: (req, res, next) ->
    id = if req.body.id is "id" then req.user.user._id else req.body.id
    (userModel.findByIdAndUpdate id, $set: req.body.user, {new: yes})
      .exec().then ((doc) -> query res, doc), next

  put: (req, res, next) ->
    (userModel.findOne email: req.body.email).exec()
      .then ((doc) -> query res, taken: doc?), next

  delete: wipeFromDB

  params: delete: name: "userID", callback: userIDParam

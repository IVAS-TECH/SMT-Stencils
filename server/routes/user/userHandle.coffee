fs = require "fs"
{join} = require "path"
userModel = require "./userModel"
query = require "./../../lib/query"
userIDParam = require "./userIDParam"
models = [
  require "./../order/orderModel"
  require "./language/languageModel"
  require "./../order/notification/notificationModel"
  require "./../order/description/descriptionModel"
  require "./../order/configuration/configurationModel"
  require "./../order/addresses/addressesModel"
]

files = join __dirname, "../../../files"

wipeFromCollection = (collection) ->
  (req, res, next) ->
    (collection.remove user: req.userID)
      .exec().then ( -> next()), next

wipeFromDB = [
  (req, res, next) ->
    req.deletes = []
    (models[0].find user: req.userID).exec()
      .then (docs) ->
        for doc in docs
          for layer in ["top", "bottom", "outline"]
            path = doc.files[layer]
            if typeof path is "string" and path.length and path not in req.deletes then req.deletes.push path
        next()
      .catch next
]

wipeFromDB.push wipeFromCollection model for model in models

wipeFromDB.push (req, res, next) ->
  (userModel.remove _id: req.userID)
    .exec().then ( -> next()), next

wipeFromDB.push (req, res, next) ->
  deleted = (for file in req.deletes
    new Promise (resolve, reject) ->
      fs.unlink (join files, file), (err) ->
        if err then reject err
        else resolve())
  (Promise.all deleted).then (-> query res), next

module.exports =

  get: (req, res, next) ->
    (userModel.findOne email: req.params.email)
      .exec().then ((doc) -> query res, taken: doc?), next

  post: [
    (req, res, next) ->
      (userModel.create req.body.user)
        .then (doc) ->
          req.register = doc
          next()
        .catch next
    (req, res, next) ->
      (models[1].create user: req.register._id, language: req.body.language)
        .then ((doc) -> query res, req.register), next
  ]

  patch: (req, res, next) ->
    update = "#{req.body.type}": req.body.value
    (userModel.findByIdAndUpdate req.user.user, $set: update, {new: true})
      .exec().then ((doc) -> query res, doc), next

  delete: wipeFromDB

  params:
    get: "email"
    delete:
      name: "userID"
      callback: userIDParam

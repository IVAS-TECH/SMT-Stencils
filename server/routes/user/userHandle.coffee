fs = require "fs"
{walk} = require "walk"
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
    (collection.remove user: req.userId)
      .exec().then ( -> next()), next

wipeFromDB = (wipeFromCollection model for model in models)

wipeFromDB.push (req, res, next) ->
  (userModel.remove _id: req.userId)
    .exec().then ( -> next()), next

wipeFromDB.push (req, res, next) ->
  walker = walk files
  deleted = []
  walker.on "file", (root, file, following) ->
    pathTo = join root, file.name
    if pathTo.match req.userID + "___"
      deleted.push new Promise (resolve, reject) ->
        fs.unlink pathTo, (err) ->
          if err then reject err
          else resolve()
    following()
  walker.on "end", -> (Promise.all deleted).then (-> query res), next
  walker.on "error", next

module.exports =

  get: (req, res, next) ->
    (userModel.findOne email: req.params.email)
      .exec().then ((doc) -> query res, taken: doc?), next

  post: (req, res, next) ->
    (userModel.create req.body.user)
      .then ((doc) -> query res, doc), next

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

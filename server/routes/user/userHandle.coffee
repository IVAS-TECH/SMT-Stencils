fs = require "fs"
{walk} = require "walk"
{join} = require "path"
userModel = require "./userModel"
send = require "./../../lib/send"
query = require "./../../lib/query"
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
    collection.remove user: req.userId, (err) ->
      if query.noErr err then next()
      else next err

wipeFromDB = (wipeFromCollection model for model in models)

wipeFromDB.push (req, res, next) ->
  userModel.remove _id: req.userId, (err, doc) ->
    if query.successful err, doc then next()
    else next err

wipeFromDB.push (req, res, next) ->
  walker = walk files
  deleted = []
  walker.on "file", (root, file, following) ->
    pathTo = join root, file.name
    if pathTo.match req.userId + "___"
      deleted.push new Promise (resolve, reject) ->
        fs.unlink pathTo, (err) ->
          if err then reject err
          else resolve()
    following()
  walker.on "end", -> (Promise.all deleted).then (-> send res), next
  walker.on "error", next

module.exports =

  get: (req, res, next) ->
    userModel.findOne email: req.params.email, (err, doc) ->
      if query.noErr err then send res, taken: doc?
      else next err

  post: (req, res, next) ->
    userModel.create req.body.user, (err, doc) ->
      query.basicHandle err, doc, res, next

  patch: (req, res, next) ->
    update = "#{req.body.type}": req.body.value
    userModel.findByIdAndUpdate req.user.user, $set: update, {new: true}, (err, doc) ->
      query.basicHandle err, doc, res, next

  delete: wipeFromDB

  params:
    get: "email"
    delete:
      name: "id"
      callback: (req, res, next, id) ->
        req.userId = req.user.user
        if id isnt "id" then req.userId = id
        next()

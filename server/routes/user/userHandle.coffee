fs = require "fs"
{walk} = require "walk"
{join} = require "path"
Promise = require "promise"
userModel = require "./userModel"
send = require "./../../lib/send"
query = require "./../../lib/query"
model =
  order: require "./../order/orderModel"
  language: require "./language/languageModel"
  notification: require "./../order/notification/notificationModel"
  description: require "./../order/description/descriptionModel"
  configuration: require "./../order/configuration/configurationModel"
  addresses: require "./../order/addresses/addressesModel"

files = join __dirname, "../../../files"

module.exports =

  get: (req, res, next) ->
    userModel.findOne email: req.params.email, (err, doc) ->
      if query.noErr err
        send res, taken: doc?
      else next err

  post: (req, res, next) ->
    userModel.create req.body.user, (err, doc) ->
      query.basicHandle err, doc, res, next

  patch: (req, res, next) ->
    update = {}
    update[req.body.type] = req.body.value
    id = req.session.get.uid
    userModel.findByIdAndUpdate id, $set: update, {new: true}, (err, doc) ->
      query.basicHandle err, doc, res, next

  delete: (req, res, next) ->
      id = req.session.get.uid
      if req.params.id isnt "id"
        id = req.params.id
      remove = (dbModel) ->
        new Promise (resolve, reject) ->
          dbModel.remove user: id, (err) ->
            if query.noErr err
              resolve()
            else reject err
      Promise.all (remove dbModel for name, dbModel of model)
        .then ->
          userModel.remove _id: id, (err, doc) ->
            if query.successful err, doc
              walker = walk files
              deleted = []
              walker.on "file", (root, file, following) ->
                pathTo = join root, file.name
                if pathTo.match id
                  deleted.push new Promise (resolve, reject) ->
                    fs.unlink pathTo, (err) ->
                      if err then reject err
                      else resolve()
                following()
              walker.on "end", ->
                (Promise.all deleted).then (-> send res), next
              walker.on "error", next
            else next err
        .catch next

  params:
    get: "email"
    delete: "id"

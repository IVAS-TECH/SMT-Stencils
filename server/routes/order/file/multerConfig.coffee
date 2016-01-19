multer = require "multer"
randomString = require "random-string"

limits =
  files: 3
  fileSize: 40000000000

fileName = (name) ->
  if name.match /\./
    return name
  "#{name}.#{name}"

module.exports = (dir) ->
  preview: ->
    multer
      storage: multer.diskStorage destination: "#{dir}/tmp"
        , filename: (req, file, cb) ->
          cb null, "#{randomString()}_#{fileName file.originalname}"
      limits: limits
  order: ->
    multer
      storage: multer.diskStorage destination: dir, filename: (req, file, cb) ->
        delimiter = "___"
        cb null, [req.session.get.uid, delimiter, randomString(), delimiter, fileName file.originalname].join ""
      limits: limits

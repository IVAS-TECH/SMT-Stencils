multer = require "multer"
{join} = require "path"

module.exports =
  preview: ->
  order: (dir) ->
    multer
      storage: multer.diskStorage destination: dir, filename: (req, file, cb) -> cb null, "#{ req.session.find req.ip}_#{file.originalname}"
      files: 6
      limits: fileSize: 40000000000

multer = require "multer"
{join} = require "path"

limits =
  files: 9
  fileSize: 40000000000


module.exports =
  preview: ->
    multer
      storage: multer.memoryStorage()
      limits: limits
  order: (dir) ->
    multer
      storage: multer.diskStorage destination: dir, filename: (req, file, cb) ->
        cb null, "#{ req.session.find req.ip}_#{file.originalname}"
      limits: limits

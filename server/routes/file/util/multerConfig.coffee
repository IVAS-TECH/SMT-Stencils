multer = require "multer"
randomString = require "random-string"
fs = require "fs-extra"
{join} = require "path"

limits =
  files: 15
  fileSize: 40000000000

fileName = (name) ->
  if name.match /./
    return name
  "#{name}.#{name}"

module.exports = (dir) ->
  preview: ->
    multer
      storage: multer.diskStorage destination: (req, file, cb) ->
        tmp = join dir, join randomString(), req.session.find req.ip
        fs.ensureDirSync tmp
        cb null, tmp
        , filename: (req, file, cb) -> cb null, fileName file.originalname
      limits: limits
  order: ->
    multer
      storage: multer.diskStorage destination: dir, filename: (req, file, cb) ->
        cb null, "#{req.session.find req.ip}_#{fileName file.originalname}"
      limits: limits

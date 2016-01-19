{join} = require "path"
fs = require "fs"
config = require "./multerConfig"
GerberToSVG = require "./../../../lib/GerberToSVG/GerberToSVG"
send = require "./../../../lib/send"
multerConfig = config join __dirname, "../../../../files"

module.exports =

  order:

    post: (req, res) ->
      fileName = (f) -> f.filename
      send res, files: (fileName file for file in req.files)

    beforeEach: multerConfig.order().any()

  preview:

    post: (req, res, next) ->
      map = req.body.map
      transform = {}
      for file in req.files
        transform[map[file.originalname]] = file.path
      converted = (svg) ->
        send res, svg
        for layer, file of transform
         fs.unlink file, (err) ->
           if err then next err
      GerberToSVG(transform).then converted, next

    beforeEach: multerConfig.preview().any()

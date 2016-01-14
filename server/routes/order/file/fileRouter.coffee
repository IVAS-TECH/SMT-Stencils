{join} = require "path"
fs = require "fs"
config = require "./multerConfig"
GerberToSVG = require "./../../../lib/GerberToSVG"
send = require "./../../../lib/send"
multerConfig = config join __dirname, "../../../../files"

module.exports =
  
  order:

    post: (req, res) ->
      fileName = (f) -> f.filename
      send res, files: (fileName file for file in req.files)

    beforeEach: multerConfig.order().any()

  preview:

    post: (req, res) ->
      files = (file.path for file in req.files)
      GerberToSVG(files).then (svg) ->
        send res, svg
        for file in files
          fs.unlink file, ->

    beforeEach: multerConfig.preview().any()

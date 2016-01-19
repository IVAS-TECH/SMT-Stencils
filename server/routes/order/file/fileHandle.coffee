{join} = require "path"
fs = require "fs"
config = require "./multerConfig"
GerberToSVG = require "./../../../lib/GerberToSVG/GerberToSVG"
send = require "./../../../lib/send"
multerConfig = config join __dirname, "../../../../files"

transformReq = (req, info) ->
  transform = {}
  for file in req.files
    transform[req.body.map[file.originalname]] = file[info]
  transform

module.exports =

  order:

    post: (req, res) ->
      send res, files: transformReq req, "filename"

    beforeEach: multerConfig.order().any()

  preview:

    post: (req, res, next) ->
      transform = transformReq req, "path"
      converted = (svg) ->
        send res, svg
        for layer, file of transform
         fs.unlink file, (err) ->
           if err then next err
      GerberToSVG(transform).then converted, next

    beforeEach: multerConfig.preview().any()

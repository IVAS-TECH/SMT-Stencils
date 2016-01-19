{join} = require "path"
fs = require "fs"
config = require "./multerConfig"
GerberToSVG = require "./../../../lib/GerberToSVG/GerberToSVG"
send = require "./../../../lib/send"
multerConfig = config join __dirname, "../../../../files"

transformReq = (req) ->
  transform = {}
  for file in req.files
    transform[req.body.map[file.originalname]] = file.path
  transform

module.exports =

  order:

    post: (req, res) ->
      send res, files: transformReq req

    beforeEach: multerConfig.order().any()

  preview:

    post: (req, res, next) ->
      transform = transformReq req
      converted = (svg) ->
        send res, svg
        for layer, file of transform
         fs.unlink file, (err) ->
           if err then next err
      GerberToSVG(transform).then converted, next

    beforeEach: multerConfig.preview().any()

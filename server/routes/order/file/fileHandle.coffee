fs = require "fs"
{join} = require "path"
Promise = require "promise"
config = require "./multerConfig"
send = require "./../../../lib/send"
GerberToSVGMiddleware = require "./../../../lib/GerberToSVG/GerberToSVGMiddleware"
multerConfig = config join __dirname, "../../../../files"

transformReq = (req, info) ->
  transform = {}
  for file in req.files
    transform[req.body.map[file.originalname]] = file[info]
  transform

module.exports =

  order: post: [
      multerConfig.order().any()
      (req, res) -> send res, files: transformReq req, "filename"
    ]

  preview: post: [
    multerConfig.preview().any()

    (req, res, next) ->
      req.gerbers = transformReq req, "path"
      next()

    GerberToSVGMiddleware "transform"

    (req, res, next) ->
      remove = (file) ->
        new Promise (resolve, reject) ->
          fs.unlink file, (err) ->
            if err then reject err
            else resolve()
      console.log (remove file for layer, file of req.gerbers)
      next()

    GerberToSVGMiddleware "send"

  ]

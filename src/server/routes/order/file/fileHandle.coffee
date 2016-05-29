{join} = require "path"
config = require "./multerConfig"
query = require "./../../../lib/query"
GerberToSVGMiddleware = require "./../../../lib/GerberToSVG/GerberToSVGMiddleware"
multerConfig = config join __dirname, "./../../../files"
tryCleanGerber = require "./tryCleanGerber"

transformReq = (info) ->
  (req, res, next) ->
    req.gerbers = {}
    req.gerbers[req.body.map[file.originalname]] = file[info] for file in req.files
    next()

module.exports =

  order: post: [
      multerConfig.order().any()
      transformReq "filename"
      (req, res) -> query res, files: req.gerbers
    ]

  preview: post: [
    multerConfig.preview().any()
    transformReq "path"
    GerberToSVGMiddleware "top"
    GerberToSVGMiddleware "bottom"
    tryCleanGerber "top"
    tryCleanGerber "bottom"
    tryCleanGerber "outline"
    GerberToSVGMiddleware "send"
  ]

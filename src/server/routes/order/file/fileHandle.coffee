fs = require "fs"
{join} = require "path"
config = require "./multerConfig"
query = require "./../../../lib/query"
GerberToSVGMiddleware = require "./../../../lib/GerberToSVG/GerberToSVGMiddleware"
multerConfig = config join __dirname, "../../../../files"

transformReq = (info) ->
  (req, res, next) ->
    req.gerbers = {}
    req.gerbers[req.body.map[file.originalname]] = file[info] for file in req.files
    next()

tryClean = (layer) ->
  (req, res, next) ->
    file = req.gerbers[layer]
    if not file? then next() else fs.unlink file, (err) ->
      if err then next err else next()

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
    tryClean "top"
    tryClean "bottom"
    tryClean "outline"
    GerberToSVGMiddleware "send"
  ]
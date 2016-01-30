fs = require "fs"
{join} = require "path"
Promise = require "promise"
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

    beforeEach: multerConfig.order().any()

    post: (req, res) ->
      send res, files: transformReq req, "filename"

  preview:

    beforeEach: multerConfig.preview().any()

    post: (req, res, next) ->
      transform = transformReq req, "path"

      (GerberToSVG transform)
        .then (svg) ->
          (Promise.all (for layer, file of transform
            new Promise (resolve, reject) ->
             fs.unlink file, (err) ->
               if err then reject err
               else resolve()
          )).then (-> send res, svg), next
        .catch next

{Router} = require "express"
{join} = require "path"
config = require "./util/multerConfig"
gerberToSVG = require "./../../lib/gerbersToSvgLayers"
router = new Router()
filesMidleware = config.order join __dirname, "../../../files"
previewMidleware = config.preview()

router.post "/files", filesMidleware.any(), (req, res) ->
  print = (f) -> console.log f.path
  print file for file in req.files

router.post "/preview", previewMidleware.any(), (req, res) ->
  fileName = (name) ->
    if name.match /./
      return name
    "#{name}.#{name}"
  entry = (file) -> content: file.buffer.toString(), path: fileName file.originalname
  files = (entry file for file in req.files)
  res.send gerberToSVG files

module.exports = router

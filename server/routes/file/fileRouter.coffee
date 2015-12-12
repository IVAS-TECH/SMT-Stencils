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
  #console.log req.files
  #get originalname and convert buffer -> string
  entry = (file) -> path: file.originalname, content: file.buffer.toString()
  files = (entry file for file in req.files)
  res.send gerberToSVG files

module.exports = router

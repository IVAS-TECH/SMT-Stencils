{Router} = require "express"
{join} = require "path"
config = require "./util/multerConfig"
GerberToSVG = require "./../../lib/GerberToSVG"
router = new Router()
multerConfig = config join __dirname, "../../../files"
filesMidleware = multerConfig.order().any()
previewMidleware = multerConfig.preview().any()

router.post "/files", filesMidleware, (req, res) ->
  print = (f) -> console.log f
  print file for file in req.files

router.post "/preview", previewMidleware, (req, res) ->
  console.log req.files


module.exports = router

{Router} = require "express"
config = require "./util/multerConfig"
{join} = require "path"
router = new Router()
filesMidleware = config.order join __dirname, "../../../files"
previewMidleware = config.preview()

router.post "/files", filesMidleware.any(), (req, res) ->
  print = (f) -> console.log f.path
  print file for file in req.files

router.post "/preview", previewMidleware.any(), (req, res) ->
  console.log req.files
  #get originalname and convert buffer -> string

module.exports = router

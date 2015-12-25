{Router} = require "express"
{join} = require "path"
fs = require "fs"
config = require "./multerConfig"
GerberToSVG = require "./../../../lib/GerberToSVG"

router = new Router()
multerConfig = config join __dirname, "../../../../files"
orderMidleware = multerConfig.order().any()
previewMidleware = multerConfig.preview().any()

router.post "/order", orderMidleware, (req, res) ->
  fileName = (f) -> f.filename
  res.send files: (fileName file for file in req.files)

router.post "/preview", previewMidleware, (req, res) ->
  files = (file.path for file in req.files)
  GerberToSVG(files).then (svg) ->
    fs.unlinkSync file for file in files
    res.send svg

module.exports = router

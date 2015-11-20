{Router} = require "express"
{order} = require "./util/multerConfig"
{join} = require "path"
router = new Router()
midleware = order join __dirname, "../../../files"

router.post "/files", midleware.any(), (req, res) ->
  print = (f) -> console.log f.path
  print file for file in req.files

module.exports = router

{Router} = require "express"
user = require "./user/userRouter"
file = require "./file/fileRouter"
config = require "./config/configRouter"
addresses = require "./addresses/addressesRouter"
router = new Router()

router.use user
router.use "/file", file
router.use config
router.use addresses

module.exports = router

{Router} = require "express"
user = require "./user/userRouter"
file = require "./file/fileRouter"
config = require "./config/configRouter"
router = new Router()

router.use user
router.use file
router.use config

module.exports = router

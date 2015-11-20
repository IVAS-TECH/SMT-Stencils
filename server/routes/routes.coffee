{Router} = require "express"
user = require "./user/userRouter"
router = new Router()
router.use user

module.exports = router

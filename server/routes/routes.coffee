{Router} = require "express"
user = require "./user/userRouter"
#order = require "./order/orderRouter"
router = new Router()

router.use user
#router.use order

module.exports = router

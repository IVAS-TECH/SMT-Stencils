{Router} = require "express"
user = require "./user/user/userRouter"
login = require "./user/login/loginRouter"
#order = require "./order/orderRouter"
router = new Router()

router.use user
router.use login
#router.use order

module.exports = router

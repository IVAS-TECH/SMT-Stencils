routerTree = require "./../lib/routerTree"
#order = require "./order/orderRouter"

handle =
  user: require "./user/userHandle"
  login: require "./user/loginHandle"

module.exports = routerTree handle

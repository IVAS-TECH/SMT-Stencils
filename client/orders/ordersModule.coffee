{angular} = require "dependencies"
moduleName = "ordersModule"

angular
  .module moduleName, []
    .controller "ordersInterface", require "./ordersInterface"
    .provider "date", require "./dateProvider"
    .directive "ivoOrders", require "./ordersDirective"
    .config require "./ordersConfig"

module.exports = moduleName

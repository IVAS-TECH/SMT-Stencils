{angular} = require "dependencies"
moduleName = "ordersModule"

angular
  .module moduleName, []
    .controller "ordersInterface", require "./ordersInterface"
    .provider "dateService", require "./dateServiceProvider"
    .directive "ivoOrders", require "./ordersDirective"
    .config require "./ordersConfig"

module.exports = moduleName

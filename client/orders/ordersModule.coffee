{angular} = require "dependencies"
moduleName = "ordersModule"

angular
  .module moduleName, []
    .controller "ordersInterface", require "./ordersInterface"
    .service "formatDateService", require "./formatDateService"
    .directive "ivoOrders", require "./ordersDirective"
    .config require "./ordersConfig"

module.exports = moduleName

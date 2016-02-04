{angular} = require "dependencies"
moduleName = "ordersModule"

deps = [
  require "./showDescription/showDescriptionModule"
  require "./notification/notificationModule"
]

angular
  .module moduleName, deps
    .constant "statusOptions", require "./statusOptions"
    .provider "dateService", require "./dateServiceProvider"
    .controller "ordersInterface", require "./ordersInterface"
    .directive "ivoOrders", require "./ordersDirective"
    .config require "./ordersConfig"

module.exports = moduleName

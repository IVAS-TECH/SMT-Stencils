{angular} = require "dependencies"
moduleName = "ordersModule"

deps = [
  require "./showDescription/showDescriptionModule"
  require "./notification/notificationModule"
]

angular
  .module moduleName, deps
    .provider "dateService", require "./dateServiceProvider"
    .factory "getStatusOptionsService", require "./getStatusOptionsService"
    .controller "ordersInterface", require "./ordersInterface"
    .directive "ivoOrders", require "./ordersDirective"
    .config require "./ordersConfig"

module.exports = moduleName

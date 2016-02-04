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
    .factory "dialogWithNoDefaultHandleService", require "./dialogWithNoDefaultHandleService"
    .controller "ordersInterface", require "./ordersInterface"
    .directive "ivoOrders", require "./ordersDirective"
    .config require "./ordersConfig"

module.exports = moduleName

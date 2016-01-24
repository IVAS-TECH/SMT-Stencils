{angular} = require "dependencies"
moduleName = "ordersModule"

angular
  .module moduleName, [require "./showDescription/showDescriptionModule"]
    .factory "getStatusOptionsService", require "./getStatusOptionsService"
    .provider "dateService", require "./dateServiceProvider"
    .controller "ordersInterface", require "./ordersInterface"
    .directive "ivoOrders", require "./ordersDirective"
    .config require "./ordersConfig"

module.exports = moduleName

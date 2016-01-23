{angular} = require "dependencies"
moduleName = "ordersModule"

noController = ->

angular
  .module moduleName, []
    .factory "showDescriptionService", require "./showDescription/showDescriptionService"
    .provider "dateService", require "./dateServiceProvider"
    .controller "showDescriptionController", noController
    .controller "ordersInterface", require "./ordersInterface"
    .directive "ivoOrders", require "./ordersDirective"
    .config require "./ordersConfig"

module.exports = moduleName

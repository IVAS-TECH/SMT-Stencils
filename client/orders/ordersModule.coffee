{angular} = require "dependencies"
moduleName = "ordersModule"

angular
  .module moduleName, []
    .controller "ordersController", require "./ordersController"
    .config require "./ordersConfig"

module.exports = moduleName

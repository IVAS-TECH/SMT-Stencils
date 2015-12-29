{angular} = require "dependencies"
moduleName = "ordersModule"

angular
  .module moduleName, []
    .controller "ordersInterface", require "./ordersInterface"
    .controller "ordersController", require "./ordersController"
    .filter "ifDate", require "./ifDateFilter"
    .config require "./ordersConfig"

module.exports = moduleName

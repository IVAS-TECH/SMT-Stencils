{angular} = require "dependencies"
moduleName = "orderModule"

angular
  .module moduleName, []
    #.controller "orderController", require "./orderController"
    .config require "./orderConfig"

module.exports = moduleName

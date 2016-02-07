{angular} = require "dependencies"
moduleName = "orderModule"

dependencies = [
  require "./addresses/addressesModule"
  require "./specific/specificModule"
  require "./configuration/configurationModule"
  require "./finalizate/finalizateModule"
]

angular.module moduleName, dependencies
  .controller "orderController", require "./orderController"
  .config require "./orderConfig"

module.exports = moduleName

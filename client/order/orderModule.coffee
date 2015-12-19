{angular} = require "dependencies"
moduleName = "orderModule"

dependencies = [
  require "./addresses/addressesModule"
  require "./specific/specificModule"
  require "./configuration/configurationModule"
]

angular
  .module moduleName, dependencies
    .controller "orderController", require "./orderController"
    .config require "./orderConfig"
    .run ($state) ->
      @$inject = ["$state"]
      #$state.go "home.order.configuration"

module.exports = moduleName

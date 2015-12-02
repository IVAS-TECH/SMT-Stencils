{angular} = require "dependencies"
moduleName = "orderModule"

angular
  .module moduleName, []
    .controller "orderController", require "./orderController"
    .config require "./orderConfig"
    .directive "ivoInclude", require "./includeDirective"
    .run ($state) ->
      @$inject = ["$state"]
      $state.go "home.order.configuration"

module.exports = moduleName

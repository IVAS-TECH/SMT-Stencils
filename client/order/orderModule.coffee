{angular} = require "dependencies"
moduleName = "orderModule"

dependencies = [
  require "./addresses/addressesModule"
  require "./specific/specificModule"
]

angular
  .module moduleName, dependencies
    .factory "scopeControllerService", require "./scopeControllerService"
    .controller "orderController", require "./orderController"
    .controller "configurationController", require "./configurationController"
    .directive "ivoInclude", require "./includeDirective"
    .directive "ivoStencilPreview", require "./stencilPreviewDirective"
    .directive "ivoChooseConfiguration", require "./chooseConfigurationDirective"
    .config require "./orderConfig"
    .run ($state) ->
      @$inject = ["$state"]
      $state.go "home.order.configuration"

module.exports = moduleName

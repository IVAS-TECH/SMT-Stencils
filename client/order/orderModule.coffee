{angular} = require "dependencies"
moduleName = "orderModule"

angular
  .module moduleName, [require "./specific/specificModule"]
    .factory "scopeControllerService", require "./scopeControllerService"
    .controller "configurationController", require "./configurationController"
    .directive "ivoInclude", require "./includeDirective"
    .directive "ivoStencilPreview", require "./stencilPreviewDirective"
    .directive "ivoChooseConfiguration", require "./chooseConfigurationDirective"
    .config require "./orderConfig"
    .run ($state) ->
      @$inject = ["$state"]
      $state.go "home.order.configuration"

module.exports = moduleName

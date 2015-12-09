{angular} = require "dependencies"
moduleName = "orderModule"

angular
  .module moduleName, []
    .factory "scopeControllerService", require "./scopeControllerService"
    .controller "configurationController", require "./configurationController"
    .directive "ivoInclude", require "./includeDirective"
    .directive "ivoStencilPreview", require "./stencilPreviewDirective"
    .directive "ivoChooseConfiguration", require "./chooseConfigurationDirective"
    .directive "ivoFile", require "./specific/fileDirective"
    .config require "./orderConfig"
    .run ($state) ->
      @$inject = ["$state"]
      $state.go "home.order.configuration"

module.exports = moduleName

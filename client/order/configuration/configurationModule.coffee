{angular} = require "dependencies"
moduleName = "configurationModule"

angular
  .module moduleName, []
    .service "progressService", require "./progressService"
    .factory "scopeControllerService", require "./scopeControllerService"
    .controller "configurationController", require "./configurationController"
    .directive "ivoInclude", require "./includeDirective"
    .directive "ivoStencilPreview", require "./stencilPreviewDirective"
    .directive "ivoChooseConfiguration", require "./chooseConfigurationDirective"

module.exports = moduleName

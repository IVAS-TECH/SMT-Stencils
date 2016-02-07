{angular} = require "dependencies"
moduleName = "configurationModule"

angular.module moduleName, [require "./base/baseModule"]
  .provider "progressService", require "./progressServiceProvider"
  .factory "scopeControllerService", require "./scopeControllerService"
  .controller "configurationInterface", require "./configurationInterface"
  .directive "ivoConfigInfo", require "./configurationInfo/configurationInfoDirective"
  .directive "ivoInclude", require "./includeDirective"
  .directive "ivoStencilPreview", require "./stencilPreview/stencilPreviewDirective"
  .config require "./configurationConfig"

module.exports = moduleName

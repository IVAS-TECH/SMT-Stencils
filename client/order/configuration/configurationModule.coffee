{angular} = require "dependencies"
moduleName = "configurationModule"

angular.module moduleName, [require "./base/baseModule"]
  .provider "progressService", require "./progressServiceProvider"
  .factory "scopeControllerService", require "./scopeControllerService"
  .controller "configurationInterface", require "./configurationInterface"
  .directive "ivstConfigInfo", require "./configurationInfo/configurationInfoDirective"
  .directive "ivstInclude", require "./includeDirective"
  .directive "ivstStencilPreview", require "./stencilPreview/stencilPreviewDirective"
  .config require "./configurationConfig"

module.exports = moduleName

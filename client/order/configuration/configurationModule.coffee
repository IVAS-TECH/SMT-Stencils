{angular} = require "dependencies"
moduleName = "configurationModule"

en = require "./language-en"
bg = require "./language-bg"

angular
  .module moduleName, [require "./base/baseModule"]
    .provider "progressService", require "./progressServiceProvider"
    .factory "scopeControllerService", require "./scopeControllerService"
    .controller "configurationInterface", require "./configurationInterface"
    .directive "ivoConfigInfo", require "./configurationInfo/configurationInfoDirective"
    .directive "ivoInclude", require "./includeDirective"
    .directive "ivoStencilPreview", require "./stencilPreview/stencilPreviewDirective"
    .config (translateProvider) ->
      @$inject = ["translateProvider"]
      translateProvider.add en, bg

module.exports = moduleName

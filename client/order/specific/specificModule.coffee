{angular} = require "dependencies"
moduleName = "specificModule"

en = require "./language-en"
bg = require "./language-bg"

dependencies = [
  require "./orderTexts/orderTextsModule"
  require "./fileContainer/fileContainerModule"
]

angular
  .module moduleName, dependencies
    .directive "ivoOrderPreview", require "./orderPreview/orderPreviewDirective"
    .directive "ivoFiles", require "./files/filesDirective"
    .directive "ivoFile", require "./file/fileDirective"
    .controller "specificController", require "./specificController"
    .config (translateProvider) ->
      @$inject = ["translateProvider"]
      translateProvider.add en, bg

module.exports = moduleName

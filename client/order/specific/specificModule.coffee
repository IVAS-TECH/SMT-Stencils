{angular} = require "dependencies"
moduleName = "specificModule"
en = require "./language-en"
bg = require "./language-bg"

angular
  .module moduleName, [require "./orderTexts/orderTextsModule"]
    .directive "ivoOrderPreview", require "./orderPreview/orderPreviewDirective"
    .directive "ivoFiles", require "./files/filesDirective"
    .directive "ivoFile", require "./file/fileDirective"
    .controller "filesController", require "./files/filesController"
    .controller "specificController", require "./specificController"
    .config (translateProvider) ->
      @$inject = ["translateProvider"]
      translateProvider.add en, bg

module.exports = moduleName

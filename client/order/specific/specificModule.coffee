{angular} = require "dependencies"
moduleName = "specificModule"

dependencies = [
  require "./orderTexts/orderTextsModule"
  require "./fileContainer/fileContainerModule"
  require "./orderSpecific/orderSpecificModule"
]

angular.module moduleName, dependencies
  .controller "specificController", require "./specificController"
  .directive "ivoOrderPreview", require "./orderPreview/orderPreviewDirective"
  .directive "ivoFiles", require "./files/filesDirective"
  .directive "ivoFile", require "./file/fileDirective"
  .config require "./specificConfig"

module.exports = moduleName

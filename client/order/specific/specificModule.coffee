{angular} = require "dependencies"
moduleName = "specificModule"

dependencies = [
  require "./orderTexts/orderTextsModule"
  require "./fileContainer/fileContainerModule"
  require "./orderSpecific/orderSpecificModule"
]

angular.module moduleName, dependencies
  .controller "specificController", require "./specificController"
  .directive "ivstOrderPreview", require "./orderPreview/orderPreviewDirective"
  .directive "ivstFiles", require "./files/filesDirective"
  .directive "ivstFile", require "./file/fileDirective"
  .config require "./specificConfig"

module.exports = moduleName

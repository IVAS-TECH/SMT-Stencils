{angular} = require "dependencies"
moduleName = "specificModule"

dependencies = [
  require "./orderTexts/orderTextsModule"
  require "./files/filesModule"
  require "./orderSpecific/orderSpecificModule"
]

angular.module moduleName, dependencies
  .controller "specificController", require "./specificController"
  .directive "ivstOrderPreview", require "./orderPreview/orderPreviewDirective"
  .config require "./specificConfig"

module.exports = moduleName
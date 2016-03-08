{angular} = require "dependencies"
moduleName = "fileContainer"

angular.module moduleName, []
  .controller "fileContainerController", require "./fileContainerController"
  .directive "ivstFile", require "./file/fileDirective"
  .directive "ivstFileContainer", require "./fileContainerDirective"

module.exports = moduleName

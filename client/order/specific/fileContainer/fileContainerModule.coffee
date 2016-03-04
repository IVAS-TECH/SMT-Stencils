{angular} = require "dependencies"
moduleName = "fileContainer"

angular.module moduleName, []
  .controller "fileContainerController", require "./fileContainerController"
  .directive "ivstFileContainer", require "./fileContainerDirective"

module.exports = moduleName

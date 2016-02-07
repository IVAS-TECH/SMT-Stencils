{angular} = require "dependencies"
moduleName = "fileContainer"

angular.module moduleName, []
  .controller "fileContainerController", require "./fileContainerController"
  .directive "ivoFileContainer", require "./fileContainerDirective"

module.exports = moduleName

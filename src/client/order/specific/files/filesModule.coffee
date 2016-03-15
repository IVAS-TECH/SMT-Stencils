{angular} = require "dependencies"
moduleName = "filesModule"

angular.module moduleName, [require "./fileContainer/fileContainerModule"]
  .directive "ivstFiles", require "./filesDirective"

module.exports = moduleName
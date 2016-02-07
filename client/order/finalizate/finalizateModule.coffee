{angular} = require "dependencies"
moduleName = "finalizateModule"

angular.module moduleName, []
  .directive "ivoViewOrder", require "./viewOrder/viewOrderDirective"

module.exports = moduleName

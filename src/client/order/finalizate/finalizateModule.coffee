{angular} = require "dependencies"
moduleName = "finalizateModule"

angular.module moduleName, []
  .directive "ivstViewOrder", require "./viewOrder/viewOrderDirective"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "finalizateModule"

angular
  .module moduleName, []
    .directive "ivoViewOrder", require "./viewOrderDirective"

module.exports = moduleName

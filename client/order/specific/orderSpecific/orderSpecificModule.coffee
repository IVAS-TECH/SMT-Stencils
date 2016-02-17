{angular} = require "dependencies"
moduleName = "orderSpecific"

angular.module moduleName, []
  .controller "orderSpecificController", require "./orderSpecificController"
  .directive "ivoOrderSpecific", require "./orderSpecificDirective"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "orderSpecific"

angular.module moduleName, []
  .controller "orderSpecificController", require "./orderSpecificController"
  .directive "ivstOrderSpecific", require "./orderSpecificDirective"

module.exports = moduleName

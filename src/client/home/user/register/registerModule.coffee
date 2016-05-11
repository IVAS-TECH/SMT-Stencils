{angular} = require "dependencies"
moduleName = "registerModule"

angular.module moduleName, []
  .factory "registerService", require "./registerService"
  .controller "registerController", require "./registerController"
  .directive "ivstIsTaken", require "./isTakenDirective"
  .config require "./registerConfig"

module.exports = moduleName

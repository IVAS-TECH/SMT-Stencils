{angular} = require "dependencies"
moduleName = "changeAccess"

angular.module moduleName, []
  .factory "changeAccessService", require "./changeAccessService"
  .controller "changeAccessController", require "./changeAccessController"

module.exports = moduleName

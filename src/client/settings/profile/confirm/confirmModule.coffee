{angular} = require "dependencies"
moduleName = "confirmModule"

angular.module moduleName, []
  .factory "confirmService", require "./confirmService"
  .controller "confirmController", require "./confirmController"
  .config require "./confirmConfig"

module.exports = moduleName

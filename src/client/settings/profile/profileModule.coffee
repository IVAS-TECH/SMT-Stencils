{angular} = require "dependencies"
moduleName = "profileModule"

angular.module moduleName, [require "./confirm/confirmModule"]
  .controller "profileController", require "./profileController"
  .config require "./profileConfig"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "adressModule"

angular.module moduleName, []
  .controller "addressController", require "./addressController"
  .directive "ivstAddress", require "./addressDirective"
  #.config require "./addressConfig"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "textField"

angular.module moduleName, []
  .controller "textFieldController", require "./textFieldController"
  .directive "ivstTextField", require "./textFieldDirective"

module.exports = moduleName

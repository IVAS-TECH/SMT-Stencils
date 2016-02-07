{angular} = require "dependencies"
moduleName = "textField"

angular.module moduleName, []
  .controller "textFieldController", require "./textFieldController"
  .directive "ivoTextField", require "./textFieldDirective"

module.exports = moduleName

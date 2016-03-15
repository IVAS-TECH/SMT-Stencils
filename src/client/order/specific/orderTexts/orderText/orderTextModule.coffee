{angular} = require "dependencies"
moduleName = "orderText"

angular.module moduleName, [require "./textField/textFieldModule"]
  .directive "ivstOrderText", require "./orderTextDirective"

module.exports = moduleName

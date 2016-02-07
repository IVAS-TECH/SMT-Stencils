{angular} = require "dependencies"
moduleName = "orderText"

angular.module moduleName, [require "./textField/textFieldModule"]
  .directive "ivoOrderText", require "./orderTextDirective"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "orderText"

angular
  .module moduleName, []
    .directive "ivoOrderText", require "./orderTextDirective"
    .directive "ivoTextField", require "./textField/textFieldDirective"
    .controller "textFieldController", require "./textField/textFieldController"

module.exports = moduleName

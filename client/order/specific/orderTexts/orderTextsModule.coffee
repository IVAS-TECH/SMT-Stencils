{angular} = require "dependencies"
moduleName = "ordersText"

angular
  .module moduleName, []
    .directive "ivoOrderTexts", require "./orderTextsDirective"
    .directive "ivoOrderText", require "./orderText/orderTextDirective"
    .directive "ivoTextField", require "./textField/textFieldDirective"
    .controller "textFieldController", require "./textField/textFieldController"

module.exports = moduleName

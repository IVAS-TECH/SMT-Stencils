{angular} = require "dependencies"
moduleName = "ordersText"

angular
  .module moduleName, []
    .controller "textFieldController", require "./textField/textFieldController"
    .directive "ivoOrderTexts", require "./orderTextsDirective"
    .directive "ivoOrderText", require "./orderText/orderTextDirective"
    .directive "ivoTextField", require "./textField/textFieldDirective"

module.exports = moduleName

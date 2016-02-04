{angular} = require "dependencies"
moduleName = "orderTexts"

angular
  .module moduleName, [require "./orderText/orderTextModule"]
    .directive "ivoOrderTexts", require "./orderTextsDirective"

module.exports = moduleName

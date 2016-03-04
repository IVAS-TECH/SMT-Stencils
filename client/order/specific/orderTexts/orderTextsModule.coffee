{angular} = require "dependencies"
moduleName = "orderTexts"

angular.module moduleName, [require "./orderText/orderTextModule"]
  .directive "ivstOrderTexts", require "./orderTextsDirective"

module.exports = moduleName

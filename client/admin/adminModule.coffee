{angular} = require "dependencies"
moduleName = "adminModule"

angular.module moduleName, [require "./showCalculatedPrice/showCalculatedPriceModule"]
  .controller "adminController", require "./adminController"
  .directive "ivoBarChart", require "./barChart/barChartDirective"
  .config require "./adminConfig"

module.exports = moduleName

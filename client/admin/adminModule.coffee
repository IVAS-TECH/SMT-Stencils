{angular} = require "dependencies"
moduleName = "adminModule"

angular.module moduleName, [require "./showCalculatedPrice/showCalculatedPriceModule"]
  .controller "adminController", require "./adminController"
  .controller "adminsController", require "./admins/adminsController"
  .directive "ivoBarChart", require "./barChart/barChartDirective"
  .config require "./adminConfig"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "adminModule"

angular.module moduleName, [require "./showCalculatedPrice/showCalculatedPriceModule"]
  .constant "accessValues", require "./accessValues"
  .controller "adminController", require "./adminController"
  .controller "usersController", require "./users/usersController"
  .directive "ivoBarChart", require "./barChart/barChartDirective"
  .config require "./adminConfig"

module.exports = moduleName

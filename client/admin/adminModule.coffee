{angular} = require "dependencies"
moduleName = "adminModule"

deps = [
  require "./showCalculatedPrice/showCalculatedPriceModule"
  require "./users/changeAccess/changeAccessModule"
]

angular.module moduleName, deps
  .controller "adminController", require "./adminController"
  .controller "usersController", require "./users/usersController"
  .directive "ivoBarChart", require "./barChart/barChartDirective"
  .config require "./adminConfig"

module.exports = moduleName

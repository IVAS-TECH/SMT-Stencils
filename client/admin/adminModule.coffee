{angular} = require "dependencies"
moduleName = "adminModule"

deps = [
  require "./showCalculatedPrice/showCalculatedPriceModule"
  require "./users/usersModule"
]

angular.module moduleName, deps
  .constant "accessValues", require "./accessValues"
  .controller "adminController", require "./adminController"
  .controller "adminsController", require "./admins/adminsController"
  .directive "ivoBarChart", require "./barChart/barChartDirective"
  .config require "./adminConfig"

module.exports = moduleName

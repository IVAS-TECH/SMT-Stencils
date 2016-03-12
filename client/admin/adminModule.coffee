{angular} = require "dependencies"
moduleName = "adminModule"

angular.module moduleName, [require "./users/usersModule"]
  .controller "adminController", require "./adminController"
  .directive "ivstBarChart", require "./barChart/barChartDirective"
  .config require "./adminConfig"

module.exports = moduleName
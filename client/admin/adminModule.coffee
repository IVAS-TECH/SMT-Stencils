{angular} = require "dependencies"
moduleName = "adminModule"

angular
  .module moduleName, []
    .controller "adminController", require "./adminController"
    .directive "ivoLineChart", require "./lineChart/lineChartDirective"
    .config require "./adminConfig"

module.exports = moduleName

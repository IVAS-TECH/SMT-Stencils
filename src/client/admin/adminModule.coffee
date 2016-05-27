{angular} = require "dependencies"
moduleName = "adminModule"

deps = [
    require "./users/usersModule"
    require "./logs/logsModule"
]

angular.module moduleName, deps
    .controller "adminController", require "./adminController"
    .directive "ivstBarChart", require "./barChart/barChartDirective"
    .config require "./adminConfig"

module.exports = moduleName

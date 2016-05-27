{angular} = require "dependencies"
moduleName = "showLogModule"

angular.module moduleName, []
    .factory "showLogService", require "./showLogService"
    .controller "showLogController", require "./showLogController"
    .controller "logController", require "./logController"
    .directive "ivstShowLog", require "./showLogDirective"

module.exports = moduleName

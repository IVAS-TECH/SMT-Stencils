{angular} = require "dependencies"
moduleName = "logsModule"

angular.module moduleName, [require "./showLog/showLogModule"]
    .constant "serverLogs", require "./serverLogs"
    .controller "logsController", require "./logsController"

module.exports = moduleName

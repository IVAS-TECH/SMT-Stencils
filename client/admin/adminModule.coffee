{angular} = require "dependencies"
moduleName = "adminModule"
noCtrl = ->

angular
  .module moduleName, []
    .service "showStatisticsService", require "./showStatisticsService"
    .controller "adminController", require "./adminController"
    .controller "statisticsController", noCtrl
    .config require "./adminConfig"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "notificationModule"

noController = ->

angular
  .module moduleName, []
    .factory "showNotificationService", require "./showNotificationService"
    .factory "notificationService", require "./notificationService"
    .controller "showNotificatioController", noController

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "notificationModule"

noController = ->

angular.module moduleName, []
  .provider "notificationService", require "./notificationServiceProvider"
  .factory "showNotificationService", require "./showNotificationService"
  .controller "showNotificationController", noController

module.exports = moduleName

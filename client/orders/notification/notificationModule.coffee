{angular} = require "dependencies"
moduleName = "notificationModule"

noController = ->

angular
  .module moduleName, []
    .provider "showNotificationService", require "./showNotificationServiceProvider"
    .provider "notificationService", require "./notificationServiceProvider"
    .controller "showNotificationController", noController

module.exports = moduleName

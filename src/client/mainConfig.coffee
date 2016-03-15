requests = require "./requests"

config = (RESTServiceProvider, uploadServiceProvider, RESTHelperServiceProvider, errorHandleServiceProvider, notificationServiceProvider, $mdThemingProvider, $compileProvider, $locationProvider) ->

  RESTServiceProvider.setBase "api"

  uploadServiceProvider.setBase "file"

  RESTHelperServiceProvider.setRequets requests

  errorHandleServiceProvider.setResource "response-error"

  notificationServiceProvider.setState "home.orders"

  $compileProvider.debugInfoEnabled no

  $locationProvider.hashPrefix "!"

  $mdThemingProvider
    .theme "default"
    .accentPalette "deep-purple"

config.$inject = ["RESTServiceProvider", "uploadServiceProvider", "RESTHelperServiceProvider", "errorHandleServiceProvider", "notificationServiceProvider", "$mdThemingProvider", "$compileProvider", "$locationProvider"]

module.exports = config

requests = require "./requests"

config = (RESTServiceProvider, uploadServiceProvider, RESTHelperServiceProvider, errorHandleServiceProvider, notificationServiceProvider, $mdThemingProvider, $compileProvider, $locationProvider, $stateProvider) ->

  RESTServiceProvider.setBase "api"

  uploadServiceProvider.setBase "file"

  RESTHelperServiceProvider.setRequets requests

  errorHandleServiceProvider.setResource "response-error"

  $stateProvider.state "notfound", url: "/notfound", template: "Not Found"

  notificationServiceProvider.setState "home.orders"

  $compileProvider.debugInfoEnabled no

  $locationProvider.hashPrefix "!"

  $mdThemingProvider
    .theme "default"
    .accentPalette "deep-purple"

config.$inject = ["RESTServiceProvider", "uploadServiceProvider", "RESTHelperServiceProvider", "errorHandleServiceProvider", "notificationServiceProvider", "$mdThemingProvider", "$compileProvider", "$locationProvider", "$stateProvider"]

module.exports = config

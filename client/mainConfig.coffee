requests = require "./requests"

config = (RESTProvider, uploadServiceProvider, RESTHelperServiceProvider, notificationServiceProvider, $mdThemingProvider, $compileProvider, $locationProvider, $stateProvider) ->

  RESTProvider.setBase "api"

  uploadServiceProvider.setBase "file"

  RESTHelperServiceProvider.setRequets requests

  notificationServiceProvider.setState "home.orders"

  $mdThemingProvider
    .theme "default"
    .accentPalette "deep-purple"

  $compileProvider.debugInfoEnabled no

  $locationProvider.hashPrefix "!"

  $stateProvider.state "notfound", url: "/notfound", template: "Not Found"

config.$inject = ["RESTProvider", "uploadServiceProvider", "RESTHelperServiceProvider", "notificationServiceProvider", "$mdThemingProvider", "$compileProvider", "$locationProvider", "$stateProvider"]

module.exports = config

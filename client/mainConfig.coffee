requests = require "./requests"

config = (RESTServiceProvider, uploadServiceProvider, RESTHelperServiceProvider, notificationServiceProvider, $mdThemingProvider, $compileProvider, $locationProvider, $stateProvider) ->

  RESTServiceProvider.setBase "api"

  uploadServiceProvider.setBase "file"

  RESTHelperServiceProvider.setRequets requests

  notificationServiceProvider.setState "home.orders"

  $stateProvider.state "notfound", url: "/notfound", template: "Not Found"

  $compileProvider.debugInfoEnabled no

  $locationProvider.hashPrefix "!"

  $mdThemingProvider
    .theme "default"
    .accentPalette "deep-purple"

config.$inject = ["RESTServiceProvider", "uploadServiceProvider", "RESTHelperServiceProvider", "notificationServiceProvider", "$mdThemingProvider", "$compileProvider", "$locationProvider", "$stateProvider"]

module.exports = config

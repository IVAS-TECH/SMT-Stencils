requests = require "./requests"

config = (RESTServiceProvider, uploadServiceProvider, RESTHelperServiceProvider, errorHandleServiceProvider, notificationServiceProvider, $mdThemingProvider, $compileProvider, $locationProvider, $stateProvider, cfpLoadingBarProvider) ->

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

  for loading in ["spinner", "loadingBar"]
    tmp = loading + "Template"
    cfpLoadingBarProvider[tmp] = cfpLoadingBarProvider[tmp].replace "id", "class='md-warn' id"

config.$inject = ["RESTServiceProvider", "uploadServiceProvider", "RESTHelperServiceProvider", "errorHandleServiceProvider", "notificationServiceProvider", "$mdThemingProvider", "$compileProvider", "$locationProvider", "$stateProvider", "cfpLoadingBarProvider"]

module.exports = config

requests = require "./requests"

config = (RESTProvider, uploadServiceProvider, RESTHelperServiceProvider, notificationServiceProvider, $mdThemingProvider, $compileProvider) ->

  RESTProvider.setBase "api"

  uploadServiceProvider.setBase "file"

  RESTHelperServiceProvider.setRequets requests

  notificationServiceProvider.setState "home.orders"

  $mdThemingProvider
    .theme "default"
    .accentPalette "deep-purple"

  $compileProvider.debugInfoEnabled no

config.$inject = ["RESTProvider", "uploadServiceProvider", "RESTHelperServiceProvider", "notificationServiceProvider", "$mdThemingProvider", "$compileProvider"]

module.exports = config

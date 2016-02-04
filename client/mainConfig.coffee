requests = require "./requests"

config = (RESTProvider, uploadServiceProvider, RESTHelperServiceProvider, notificationServiceProvider, $mdThemingProvider) ->

  RESTProvider.setBase "api"

  uploadServiceProvider.setBase "file"

  RESTHelperServiceProvider.setRequets requests

  notificationServiceProvider.setState "home.orders"

  $mdThemingProvider
    .theme "default"
    .accentPalette "deep-purple"

config.$inject = ["RESTProvider", "uploadServiceProvider", "RESTHelperServiceProvider", "notificationServiceProvider", "$mdThemingProvider"]

module.exports = config

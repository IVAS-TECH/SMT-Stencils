requests = require "./requests"

config = (RESTProvider, uploadServiceProvider, RESTHelperServiceProvider, $mdThemingProvider) ->

  RESTProvider.setBase "api"

  uploadServiceProvider.setBase "file"

  RESTHelperServiceProvider.setRequets requests

  $mdThemingProvider
    .theme "default"
    .accentPalette "deep-purple"

config.$inject = ["RESTProvider", "uploadServiceProvider", "RESTHelperServiceProvider", "$mdThemingProvider"]

module.exports = config

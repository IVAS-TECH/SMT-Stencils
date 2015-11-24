dependencies = require "dependencies"
angular = dependencies.angular
moduleName = "main"

dependencies = [
  dependencies["angular-animate"]
  dependencies["angular-aria"]
  dependencies["angular-messages"]
  dependencies["angular-material"]
  require "ui-router"
  #require "safe-ng-file-upload"
  require "./helper/helperModule"
  require "./root/rootModule"
]

angular
  .module moduleName, dependencies
    .config ($mdThemingProvider, RESTProvider) ->
      config = @
      config.$inject = ["$mdThemingProvider", "RESTProvider"]
      RESTProvider.setBase "client"
      $mdThemingProvider
        .theme "style"
          .primaryPalette "indigo"
          .accentPalette "orange"

angular
  .element document
    .ready -> angular.bootstrap document, [moduleName]

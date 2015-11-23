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
  require "./templateProvider"
  require "./root/rootModule"
]

angular
  .module moduleName, dependencies
  .config ($mdThemingProvider) ->
    @$inject = ["$mdThemingProvider"]
    $mdThemingProvider.theme "main-theme"
      .primaryPalette "teal"
      .accentPalette "brown"

angular
  .element document
    .ready -> angular.bootstrap document, [moduleName]

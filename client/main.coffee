dependencies = require "dependencies"
angular = dependencies.angular
moduleName = "main"

dependencies = [
  dependencies["angular-animate"]
  dependencies["angular-aria"]
  dependencies["angular-messages"]
  dependencies["angular-material"]
  require "ui-router"
  require "angular-translate"
  #require "safe-ng-file-upload"
  require "./helper/helperModule"
  require "./translate/translateModule"
  require "./home/homeModule"
  require "./settings/settingsModule"
]

angular
  .module moduleName, dependencies
    .config (RESTProvider) ->
      @$inject = ["RESTProvider"]
      RESTProvider.setBase "client"

angular
  .element document
    .ready -> angular.bootstrap document, [moduleName]

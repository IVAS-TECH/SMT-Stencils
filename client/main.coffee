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
  require "./translate/translateModule"
  require "./helper/helperModule"
  require "./home/homeModule"
]

angular
  .module moduleName, dependencies
    .config (RESTProvider) ->
      config = @
      config.$inject = ["RESTProvider"]
      RESTProvider.setBase "client"

angular
  .element document
    .ready -> angular.bootstrap document, [moduleName]

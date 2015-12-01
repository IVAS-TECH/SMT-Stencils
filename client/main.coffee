dependencies = require "dependencies"
angular = dependencies.angular
moduleName = "main"

deps = [
  dependencies["angular-animate"]
  dependencies["angular-aria"]
  dependencies["angular-messages"]
  dependencies["angular-material"]
  dependencies["ng-file-upload"]
  require "ui-router"
  require "angular-translate"
  require "./helper/helperModule"
  require "./translate/translateModule"
  require "./home/homeModule"
  require "./order/orderModule"
  require "./settings/settingsModule"
]

angular
  .module moduleName, deps
    .config (RESTProvider) ->
      @$inject = ["RESTProvider"]
      RESTProvider.setBase "client"

angular
  .element document
    .ready -> angular.bootstrap document, [moduleName]

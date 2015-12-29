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
  require "./orders/ordersModule"
  require "./settings/settingsModule"
  require "./admin/adminModule"
]

angular
  .module moduleName, deps
    .config (RESTProvider, uploadServiceProvider) ->
      @$inject = ["RESTProvider", "uploadServiceProvider"]
      RESTProvider.setBase "client"
      uploadServiceProvider.setBase "file"

angular
  .element document
    .ready -> angular.bootstrap document, [moduleName]

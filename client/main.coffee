dependencies = require "dependencies"
angular = dependencies.angular
moduleName = "main"

deps = [
  dependencies["angular-animate"]
  dependencies["angular-aria"]
  dependencies["angular-messages"]
  dependencies["angular-material"]
  dependencies["ng-file-upload"]
  dependencies["angular-chart.js"]
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

run = (RESTHelperService) -> RESTHelperService.order.find (res) -> console.log res
run.$inject = ["RESTHelperService"]

angular
  .module moduleName, deps
    .config require "./mainConfig"
    .run run

angular
  .element document
    .ready -> angular.bootstrap document, [moduleName], strictDi: on

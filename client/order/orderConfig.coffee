en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, translateProvider, progressServiceProvider) ->

  translateProvider.add en, bg

  progressServiceProvider.setState "home.order"
  
  progressServiceProvider.setExclude ["finalizate"]

  $stateProvider
    .state "home.order",
      url: "/order"
      controller: "orderController as orderCtrl"
      templateUrl: "orderView"
    .state "home.order.configuration", templateUrl: "configurationView"
    .state "home.order.specific",
      controller: "specificController as specificCtrl"
      templateUrl: "specificView"
    .state "home.order.addresses", templateUrl: "addressesView"
    .state "home.order.price", templateUrl: "showPriceInfoView"
    .state "home.order.finalizate", templateUrl: "finalizateView"

config.$inject = ["$stateProvider", "translateProvider", "progressServiceProvider"]

module.exports = config

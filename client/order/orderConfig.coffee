en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, templateProvider, translateProvider, progressServiceProvider) ->

  translateProvider.add en, bg

  progressServiceProvider.setState "home.order"

  progressServiceProvider.setMove ["configuration", "specific", "addresses", "finalizate"]

  $stateProvider
    .state "home.order",
      url: "/order"
      controller: "orderController as orderCtrl"
      template: templateProvider.provide "orderView"
    .state "home.order.configuration", template: templateProvider.provide "configurationView"
    .state "home.order.specific",
      controller: "specificController as specificCtrl"
      template: templateProvider.provide "specificView"
    .state "home.order.addresses", template: templateProvider.provide "addressesView"
    .state "home.order.finalizate", template: templateProvider.provide "finalizateView"

config.$inject = ["$stateProvider", "templateProvider", "translateProvider", "progressServiceProvider"]

module.exports = config

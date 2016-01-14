en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider, progressServiceProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider", "progressServiceProvider"]

  translateProvider.add en, bg

  progressServiceProvider.setState "home.order"

  progressServiceProvider.setMove ["configuration", "specific", "addresses", "finalizate"]

  $stateProvider
    .state "home.order",
      url: "/order"
      controller: "orderController as orderCtrl"
      template: templateProvider.provide "orderView"
    .state "home.order.configuration",
      controller: "configurationController as baseCtrl"
      template: templateProvider.provide "baseView"
    .state "home.order.specific",
      controller: "specificController as specificCtrl"
      template: templateProvider.provide "specificView"
    .state "home.order.addresses",
      controller: "addressesController as baseCtrl"
      template: templateProvider.provide "baseView"
    .state "home.order.finalizate",
      template: templateProvider.provide "finalizateView"

en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider"]
  translateProvider.add en, bg
  $stateProvider
    .state "home.order", url: "/order", controller: "orderController as orderCtrl", template: templateProvider.provide "orderView"
    .state "home.order.configuration", controller: "configurationController as configCtrl", template: templateProvider.provide "configurationView"
    .state "home.order.specific", controller: "specificController as specificCtrl", template: templateProvider.provide "specificView"
    .state "home.order.addresses", controller: "addressesController as addressesCtrl", template: templateProvider.provide "addressesView"
    .state "home.order.finalizate", template: templateProvider.provide "finalizateView"

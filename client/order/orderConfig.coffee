en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider"]
  translateProvider.add en, bg
  $stateProvider
    .state "home.order", url: "/order", controller: "orderController as x", template: templateProvider.provide "orderView"
    .state "home.order.configuration", template: templateProvider.provide "configurationView"
    #.state "home.order.order"###

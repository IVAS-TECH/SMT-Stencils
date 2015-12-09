en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider"]
  translateProvider.add en, bg
  $stateProvider
    .state "home.order", url: "/order", template: templateProvider.provide "orderView"
    .state "home.order.configuration", controller: "configurationController as configCtrl", template: templateProvider.provide "configurationView"
    .state "home.order.specific", template: templateProvider.provide "specificView"

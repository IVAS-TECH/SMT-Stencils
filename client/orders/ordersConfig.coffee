en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider"]

  translateProvider.add en, bg

  $stateProvider
    .state "home.orders",
      url: "/orders"
      template: templateProvider.provide "ordersView"

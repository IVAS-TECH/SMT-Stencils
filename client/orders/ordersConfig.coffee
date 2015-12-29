en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, $mdDateLocaleProvider, templateProvider, translateProvider) ->
  @$inject = ["$stateProvider", "$mdDateLocaleProvider", "templateProvider", "translateProvider"]

  translateProvider.add en, bg

  $stateProvider
    .state "home.orders",
      url: "/orders"
      controller: "ordersController as ordersCtrl"
      template: templateProvider.provide "ordersView"

  $mdDateLocaleProvider.formatDate = (date) ->
    [date.getDate(), date.getDay(), date.getFullYear()].join "\/"

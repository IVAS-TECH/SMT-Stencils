en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider, $mdDateLocaleProvider, dateServiceProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider", "$mdDateLocaleProvider", "dateServiceProvider"]

  translateProvider.add en, bg

  $stateProvider
    .state "home.orders",
      url: "/orders"
      template: templateProvider.provide "ordersView"

  $mdDateLocaleProvider.formatDate = dateServiceProvider.formater()

  $mdDateLocaleProvider.parseDate = dateServiceProvider.parser()

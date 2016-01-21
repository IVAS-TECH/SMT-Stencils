en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider, $mdDateLocaleProvider, dateProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider", "$mdDateLocaleProvider", "dateProvider"]

  translateProvider.add en, bg

  $stateProvider
    .state "home.orders",
      url: "/orders"
      template: templateProvider.provide "ordersView"

  $mdDateLocaleProvider.formatDate = dateProvider.formater()

  $mdDateLocaleProvider.parseDate = dateProvider.parser()

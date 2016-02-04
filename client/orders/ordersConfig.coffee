en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, templateProvider, translateProvider, $mdDateLocaleProvider, dateServiceProvider, notificationServiceProvider) ->

  translateProvider.add en, bg

  $stateProvider
    .state "home.orders",
      url: "/orders"
      template: templateProvider.provide "ordersView"

  $mdDateLocaleProvider.formatDate = dateServiceProvider.formater()

  $mdDateLocaleProvider.parseDate = dateServiceProvider.parser()

  notificationServiceProvider.setState "home.order"

config.$inject = ["$stateProvider", "templateProvider", "translateProvider", "$mdDateLocaleProvider", "dateServiceProvider", "notificationServiceProvider"]

module.exports = config

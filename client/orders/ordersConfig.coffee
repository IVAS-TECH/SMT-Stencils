en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, translateProvider, $mdDateLocaleProvider, dateServiceProvider) ->

  translateProvider.add en, bg

  $stateProvider
    .state "home.orders",
      url: "/orders"
      templateUrl: "ordersView"

  $mdDateLocaleProvider.formatDate = dateServiceProvider.formater()

  $mdDateLocaleProvider.parseDate = dateServiceProvider.parser()

config.$inject = ["$stateProvider", "translateProvider", "$mdDateLocaleProvider", "dateServiceProvider"]

module.exports = config
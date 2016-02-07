en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, $urlRouterProvider, translateProvider) ->

  translateProvider.add en, bg

  $stateProvider
    .state "home",
      controller: "homeController as homeCtrl"
      templateUrl: "homeView"
    .state "home.about", url: "/about", template: "A"
    .state "home.technologies", url: "/technologies", template: "T"
    .state "home.contacts", url: "/contacts", template: "C"

  $urlRouterProvider.otherwise "/about"

config.$inject = ["$stateProvider", "$urlRouterProvider", "translateProvider"]

module.exports = config

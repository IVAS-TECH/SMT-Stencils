en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, $urlRouterProvider, templateProvider, translateProvider) ->
  @$inject = ["$stateProvider", "$urlRouterProvider", "templateProvider", "translateProvider"]

  translateProvider.add en, bg

  $stateProvider
    .state "home",
      controller: "homeController as homeCtrl"
      template: templateProvider.provide "homeView"
    .state "home.about", url: "/about", template: "A"
    .state "home.technologies", url: "/technologies", template: "T"
    .state "home.contacts", url: "/contacts", template: "C"

  $urlRouterProvider.otherwise "/about"

en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider"]

  translateProvider.add en, bg

  $stateProvider
    .state "home",
      url: ""
      controller: "homeController as homeCtrl"
      template: templateProvider.provide "homeView"
    .state "home.about", url: "/about", template: "A"
    .state "home.technologies", url: "/technologies", template: "T"
    .state "home.contacts", url: "/contacts", template: "C"

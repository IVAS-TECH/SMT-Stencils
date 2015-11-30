en = require "./language-en"
bg = require "./language-bg"
module.exports = ($stateProvider, templateProvider, translateProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider", "translateProvider"]
  translateProvider.add en, bg
  $stateProvider
    .state "home", url: "", template: templateProvider.provide "homeView"
    .state "home.about", url: "/about", template: "A"
    .state "home.technologies", url: "/technologies", template: "T"
    .state "home.order", url: "/order", template: "O"
    .state "home.contacts", url: "/contacts", template: "C"

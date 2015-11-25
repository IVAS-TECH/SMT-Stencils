en = require "./language-en"
bg = require "./language-bg"
module.exports = ($stateProvider, templateProvider, translateProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider", "translateProvider"]
  translateProvider.add en, bg
  $stateProvider
    .state "home", template: templateProvider.provide "homeView"
    .state "home.about", template: "A"
    .state "home.technologies", template: "T"
    .state "home.order", template: "O"
    .state "home.contacts", template: "C"

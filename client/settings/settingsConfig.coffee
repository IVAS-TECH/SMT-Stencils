en = require "./language-en"
bg = require "./language-bg"
module.exports = ($stateProvider, templateProvider, translateProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider", "translateProvider"]
  translateProvider.add en, bg
  $stateProvider
    .state "home.settings", template: templateProvider.provide "settingsView"
    .state "home.settings.profile", template: "P"
    .state "home.settings.configurations", template: "C"
    .state "home.settings.orders", template: "O"

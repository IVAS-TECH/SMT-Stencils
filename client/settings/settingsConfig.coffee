en = require "./language-en"
bg = require "./language-bg"
module.exports = ($stateProvider, templateProvider, translateProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider", "translateProvider"]
  translateProvider.add en, bg
  $stateProvider
    .state "home.settings", url: "/settings", template: templateProvider.provide "settingsView"
    .state "home.settings.profile", url: "/settings/profile", controller: "profileController as profileCtrl", template: templateProvider.provide "profileView"
    .state "home.settings.configurations", url: "/settings/configurations", controller: "configurationsController as configCtrl", template: templateProvider.provide "configurationView"
    .state "home.settings.addresses", url: "/setting/addresses", controller: "_addressesController as addressesCtrl", template: templateProvider.provide "addressesView"

en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider"]

  translateProvider.add en, bg

  $stateProvider
    .state "home.settings",
      url: "/settings"
      template: templateProvider.provide "settingsView"
    .state "home.settings.profile",
      url: "/profile"
      controller: "profileController as profileCtrl"
      template: templateProvider.provide "profileView"
    .state "home.settings.configurations", template: templateProvider.provide "configurationSettingsView"
    .state "home.settings.addresses", template: templateProvider.provide "addressesSettingsView"

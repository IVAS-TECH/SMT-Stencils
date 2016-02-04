en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, templateProvider, translateProvider) ->

  translateProvider.add en, bg

  $stateProvider
    .state "home.settings",
      url: "/settings"
      template: templateProvider.provide "settingsView"
    .state "home.settings.profile",
      url: "/profile"
      controller: "profileController as profileCtrl"
      template: templateProvider.provide "profileView"
    .state "home.settings.configurations",
      url: "/configurations"
      template: templateProvider.provide "configurationSettingsView"
    .state "home.settings.addresses",
      url: "/addresses"
      template: templateProvider.provide "addressesSettingsView"

config.$inject = ["$stateProvider", "templateProvider", "translateProvider"]

module.exports = config

en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, translateProvider) ->

  translateProvider.add en, bg

  $stateProvider
    .state "home.settings", url: "/settings", templateUrl: "settingsView"
    .state "home.settings.profile", url: "/profile", controller: "profileController as profileCtrl", templateUrl: "profileView"
    .state "home.settings.configurations", url: "/configurations", templateUrl: "configurationSettingsView"
    .state "home.settings.addresses", url: "/addresses", templateUrl:"addressesSettingsView"

config.$inject = ["$stateProvider", "translateProvider"]

module.exports = config

module.exports = ($stateProvider, templateProvider, $mdThemingProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider", "$mdThemingProvider"]
  $mdThemingProvider.theme "style"
    .primaryPalette "indigo"
    .accentPalette "orange"
  $stateProvider
    .state "root", template: (templateProvider.provide "rootView"), controller: "rootCntrl as root"

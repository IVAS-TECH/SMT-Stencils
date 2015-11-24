module.exports = ($stateProvider, templateProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider"]
  $stateProvider
    .state "home", template: templateProvider.provide "homeView"
    .state "home.about", template: "A"
    .state "home.technologies", template: "T"
    .state "home.order", template: "O"
    .state "home.contacts", template: "C"
    .state "home.settings", template: "S"

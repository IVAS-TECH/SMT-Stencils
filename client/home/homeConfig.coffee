module.exports = ($stateProvider, templateProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider"]
  $stateProvider
    .state "home", template: (templateProvider.provide "homeView"), controller: "homeController as homeCtrl"
    .state "home.about", template: "About"
    .state "home.technologies", template: "Tech"
    .state "home.order", template: "Order"
    .state "home.contacts", template: "contact"
    .state "home.settings", template: "Settings"

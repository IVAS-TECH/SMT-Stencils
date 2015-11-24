module.exports = ($stateProvider, templateProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider"]
  $stateProvider
    .state "home", template: templateProvider.provide "homeView"
    .state "home.about", template: templateProvider.provide "testView"
    .state "home.technologies", template: templateProvider.provide "testView"
    .state "home.order", template: templateProvider.provide "testView"
    .state "home.contacts", template: templateProvider.provide "testView"
    .state "home.settings", template: templateProvider.provide "testView"

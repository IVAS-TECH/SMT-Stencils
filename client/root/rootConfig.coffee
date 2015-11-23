module.exports = ($stateProvider, templateProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider"]
  $stateProvider
    .state "root", template: (templateProvider.provide "rootView"), controller: "rootController as root"
    .state "root.about", template: "About"
    .state "root.technologies", template: "Tech"
    .state "root.order", template: "Order"
    .state "root.contacts", template: "contact"
    .state "root.settings", template: "Settings"
  config

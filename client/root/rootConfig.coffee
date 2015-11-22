module.exports = ($stateProvider, templateProvider) ->
  config = @
  config.$inject = ["$stateProvider", "templateProvider"]
  $stateProvider
    .state "root", template: (templateProvider.provide "rootView"), controller: "rootCntrl as root"

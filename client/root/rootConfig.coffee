template = require "template"

module.exports = ($stateProvider) ->
  config = @
  config.$inject = ["$stateProvider"]
  $stateProvider
    .state "root", template: (template "rootView"), controller: "rootCntrl as root"

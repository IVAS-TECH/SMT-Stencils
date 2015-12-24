{angular} = require "dependencies"
moduleName = "adressesModule"
en = require "./language-en"
bg = require "./language-bg"

angular
  .module moduleName, []
    .controller "addressesInterface", require "./addressesInterface"
    .controller "addressesController", require "./addressesController"
    .controller "addressController", require "./addressController"
    .directive "ivoAddress", require "./addressDirective"
    .config (translateProvider) ->
      @$inject = ["translateProvider"]
      translateProvider.add en, bg


module.exports = moduleName

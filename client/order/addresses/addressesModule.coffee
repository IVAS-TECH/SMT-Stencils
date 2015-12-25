{angular} = require "dependencies"
moduleName = "adressesModule"
en = require "./language-en"
bg = require "./language-bg"

angular
  .module moduleName, [require "./address/addressModule"]
    .factory "infoOnlyService", require "./infoOnlyService"
    .controller "addressesInterface", require "./addressesInterface"
    .controller "addressesController", require "./addressesController"
    .config (translateProvider) ->
      @$inject = ["translateProvider"]
      translateProvider.add en, bg

module.exports = moduleName

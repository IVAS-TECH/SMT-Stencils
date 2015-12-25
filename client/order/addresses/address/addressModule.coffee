{angular} = require "dependencies"
moduleName = "adressModule"
#en = require "./language-en"
#bg = require "./language-bg"

angular
  .module moduleName, []
    .controller "addressController", require "./addressController"
    .directive "ivoAddress", require "./addressDirective"
    ###.config (translateProvider) ->
      @$inject = ["translateProvider"]
      translateProvider.add en, bg###

module.exports = moduleName

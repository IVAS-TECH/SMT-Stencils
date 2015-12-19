{angular} = require "dependencies"
moduleName = "registerModule"
#en = require "./language-en"
#bg = require "./language-bg"

angular
    .module moduleName, []
      .directive "ivoEmailTaken", require "./emailTakenDirective"
      .factory "registerService", require "./registerService"
      .controller "registerController", require "./registerController"
      ###.config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg###

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "registerModule"
en = require "./language-en"
bg = require "./language-bg"

angular
    .module moduleName, []
      .factory "registerService", require "./registerService"
      .controller "registerController", require "./registerController"
      .directive "ivoEmailTaken", require "./emailTakenDirective"
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg

module.exports = moduleName

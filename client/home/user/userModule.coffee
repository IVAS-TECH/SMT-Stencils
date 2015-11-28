{angular} = require "dependencies"
moduleName = "userModule"
en = require "./language-en"
bg = require "./language-bg"

angular
    .module moduleName, []
      .factory "registerService", require "./registerService"
      .controller "registerController", require "./registerController"
      .controller "userController", require "./userController"
      .directive "ivoEmailTaken", require "./emailTakenDirective"
      .directive "ivoUser", require "./userDirective"
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg

module.exports = moduleName

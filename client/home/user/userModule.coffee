{angular} = require "dependencies"
moduleName = "userModule"
en = require "./language-en"
bg = require "./language-bg"
dialogController = require "./dialogController"

angular
    .module moduleName, []
      .factory "authenticationService", require "./authenticationService"
      .factory "tryAgainService", require "./tryAgainService"
      .factory "loginService", require "./loginService"
      .factory "registerService", require "./registerService"
      .controller "registerController", dialogController "register"
      .controller "loginController", dialogController "login"
      .controller "tryAgainController", dialogController()
      .controller "userController", require "./userController"
      .directive "ivoEmailTaken", require "./emailTakenDirective"
      .directive "ivoUser", require "./userDirective"
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg

module.exports = moduleName

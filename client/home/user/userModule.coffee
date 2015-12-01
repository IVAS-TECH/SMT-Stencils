{angular} = require "dependencies"
moduleName = "userModule"
en = require "./language-en"
bg = require "./language-bg"
noController = ->

angular
    .module moduleName, []
      .factory "simpleDialogService", require "./simpleDialogService"
      .factory "authenticationService", require "./authenticationService"
      .factory "tryAgainService", require "./tryAgainService"
      .factory "loginService", require "./loginService"
      .factory "registerService", require "./registerService"
      .controller "registerController", require "./registerController"
      .controller "loginController", require "./loginController"
      .controller "tryAgainController", noController
      .controller "simpleDialogController", noController
      .controller "userController", require "./userController"
      .directive "ivoEmailTaken", require "./emailTakenDirective"
      .directive "ivoUser", require "./userDirective"
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg

module.exports = moduleName

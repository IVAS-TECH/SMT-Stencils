{angular} = require "dependencies"
moduleName = "userModule"
en = require "./language-en"
bg = require "./language-bg"
noController = ->

dependencies = [
  require "./login/loginModule"
  require "./register/registerModule"
]

angular
    .module moduleName, dependencies
      .factory "simpleDialogService", require "./simpleDialog/simpleDialogService"
      .factory "authenticationService", require "./authenticationService"
      .factory "tryAgainService", require "./tryAgain/tryAgainService"
      .controller "tryAgainController", noController
      .controller "simpleDialogController", noController
      .controller "userController", require "./userController"
      .directive "ivoUser", require "./userDirective"
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg

module.exports = moduleName

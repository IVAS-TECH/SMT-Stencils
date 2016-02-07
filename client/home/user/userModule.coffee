{angular} = require "dependencies"
moduleName = "userModule"

noController = ->

dependencies = [
  require "./register/registerModule"
  require "./login/loginModule"
]

angular.module moduleName, dependencies
  .factory "dialogWithTitleService", require "./dialogWithTitleService"
  .factory "simpleDialogService", require "./simpleDialog/simpleDialogService"
  .factory "authenticationService", require "./authenticationService"
  .factory "tryAgainService", require "./tryAgain/tryAgainService"
  .controller "tryAgainController", noController
  .controller "simpleDialogController", noController
  .controller "userController", require "./userController"
  .directive "ivoUser", require "./userDirective"
  .config require "./userConfig"

module.exports = moduleName

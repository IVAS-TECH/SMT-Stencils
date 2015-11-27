{angular} = require "dependencies"
moduleName = "userModule"
en = require "./language-en"
bg = require "./language-bg"

angular
    .module moduleName, []
      .factory "showDialogService", require "./showDialogService"
      .factory "registerService", require "./registerService"
      .controller "userController", require "./userController"
      .directive "ivoUser", require "./userDirective"
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg

module.exports = moduleName

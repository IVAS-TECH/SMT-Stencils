{angular} = require "dependencies"
moduleName = "loginModule"
#en = require "./language-en"
#bg = require "./language-bg"

angular
    .module moduleName, []
      .factory "loginService", require "./loginService"
      .controller "loginController", require "./loginController"
      ###.config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg###

module.exports = moduleName

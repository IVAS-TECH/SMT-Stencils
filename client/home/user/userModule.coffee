{angular} = require "dependencies"
moduleName = "userModule"
en = require "./language-en"
bg = require "./language-bg"

angular
    .module moduleName, []
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg
      .directive "ivoUser", require "./userDirective"

module.exports = moduleName

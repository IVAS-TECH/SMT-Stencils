{angular} = require "dependencies"
moduleName = "profileModule"
en = require "./language-en"
bg = require "./language-bg"

angular
    .module moduleName, []
      .factory "confirmService", require "./confirmService"
      .controller "confirmController", require "./confirmController"
      .controller "profileController", require "./profileController"
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "confirmModule"
en = require "./language-en"
bg = require "./language-bg"

angular
    .module moduleName, []
      .factory "confirmService", require "./confirmService"
      .controller "confirmController", require "./confirmController"
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg

module.exports = moduleName

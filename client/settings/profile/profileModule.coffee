{angular} = require "dependencies"
moduleName = "profileModule"
en = require "./language-en"
bg = require "./language-bg"

angular
    .module moduleName, [require "./confirm/confirmModule"]
      .controller "profileController", require "./profileController"
      .config (translateProvider) ->
        @$inject = ["translateProvider"]
        translateProvider.add en, bg

module.exports = moduleName

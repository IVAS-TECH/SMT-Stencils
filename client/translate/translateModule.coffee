{angular} = require "dependencies"
moduleName = "translateModule"
en = require "./language-en"
bg = require "./language-bg"

angular
  .module moduleName, []
    .controller "translateController", require "./translateController"
    .directive "ivoTranslate", require "./translateDirective"
    .config (translateProvider) ->
      config = @
      config.$inject = ["translateProvider"]
      translateProvider.add en, bg
      $translateProvider = translateProvider.$get()
      $translateProvider.use "bg"
      $translateProvider.useSanitizeValueStrategy "escape"

module.exports = moduleName

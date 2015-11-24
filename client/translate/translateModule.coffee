{angular} = require "dependencies"
moduleName = "translateModule"
bg = require "./lenguage-bg"
en = require "./lenguage-en"

angular
  .module moduleName, [require "../home/translate/homeTranslateModule"]
    .controller "translateController", require "./translateController"
    .directive "tTranslate", require "./translateDirective"
    .config ($translateProvider) ->
      config = @
      config.$inject = ["$translateProvider"]
      bg $translateProvider
      en $translateProvider
      $translateProvider.use "bg"
      $translateProvider.useSanitizeValueStrategy "escape"

module.exports = moduleName

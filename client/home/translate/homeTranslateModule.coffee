{angular} = require "dependencies"
moduleName = "homeTranslateModule"
en = require "./language-en"
bg = require "./language-bg"

angular
  .module moduleName, []
  .config ($translateProvider) ->
    config = @
    config.$inject = ["$translateProvider"]
    en $translateProvider
    bg $translateProvider

module.exports = moduleName

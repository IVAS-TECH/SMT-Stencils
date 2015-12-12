{angular} = require "dependencies"
moduleName = "specificModule"
en = require "./language-en"
bg = require "./language-bg"

angular
  .module moduleName, []
    .directive "ivoFiles", require "./filesDirective"
    .directive "ivoFile", require "./fileDirective"
    .controller "filesController", require "./filesController"
    .controller "specificController", require "./specificController"
    .config (translateProvider) ->
      @$inject = ["translateProvider"]
      translateProvider.add en, bg


module.exports = moduleName

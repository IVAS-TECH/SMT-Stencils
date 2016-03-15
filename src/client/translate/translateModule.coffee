{angular} = require "dependencies"
moduleName = "translateModule"

angular.module moduleName, []
  .controller "translateController", require "./translateController"
  .directive "ivstTranslate", require "./translateDirective"
  .config require "./translateConfig"

module.exports = moduleName

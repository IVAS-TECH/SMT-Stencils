{angular} = require "dependencies"
moduleName = "base"

angular
  .module moduleName, []
    .controller "baseInterface", require "./baseInterface"
    .directive "ivstBase", require "./baseDirective"

module.exports = moduleName

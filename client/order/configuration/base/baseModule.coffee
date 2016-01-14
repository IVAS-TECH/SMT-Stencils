{angular} = require "dependencies"
moduleName = "base"

angular
  .module moduleName, []
    .controller "baseInterface", require "./baseInterface"
    .directive "ivoBase", require "./baseDirective"

module.exports = moduleName

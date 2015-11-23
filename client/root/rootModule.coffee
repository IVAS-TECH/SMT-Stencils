{angular} = require "dependencies"
moduleName = "rootModule"

angular
    .module moduleName, []
      .config require "./rootConfig"
      .run require "./rootRun"
      .controller "rootController", require "./rootController"

module.exports = moduleName

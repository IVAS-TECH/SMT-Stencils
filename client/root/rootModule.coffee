angular = require "angular"
moduleName = "rootModule"

angular
    .module moduleName, []
      .controller "rootCntrl", require "./rootCntrl"
      .config require "./rootConfig"
      .run require "./rootRun"

module.exports = moduleName

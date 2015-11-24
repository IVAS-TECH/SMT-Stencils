{angular} = require "dependencies"
moduleName = "homeModule"

angular
    .module moduleName, []
      .config require "./homeConfig"
      .run require "./homeRun"
      .controller "homeController", require "./homeController"

module.exports = moduleName

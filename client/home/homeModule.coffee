{angular} = require "dependencies"
moduleName = "homeModule"

angular
    .module moduleName, []
      .config require "./homeConfig"
      .run require "./homeRun"
      .controller "homeController", require "./homeController"
      .directive "ivoUser", require "./user/userDirective"

module.exports = moduleName

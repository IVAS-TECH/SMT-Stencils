{angular} = require "dependencies"
moduleName = "homeModule"

angular
    .module moduleName, []
      .config require "./homeConfig"
      .directive "ivoUser", require "./user/userDirective"
      .run require "./homeRun"

module.exports = moduleName

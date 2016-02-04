{angular} = require "dependencies"
moduleName = "registerModule"

angular
    .module moduleName, []
      .factory "registerService", require "./registerService"
      .controller "registerController", require "./registerController"
      .directive "ivoEmailTaken", require "./emailTakenDirective"
      .config require "./registerConfig"

module.exports = moduleName

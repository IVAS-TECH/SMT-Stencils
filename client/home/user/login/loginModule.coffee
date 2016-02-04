{angular} = require "dependencies"
moduleName = "loginModule"

angular
    .module moduleName, []
      .factory "circularDialogService", require "./circularDialogService"
      .factory "loginService", require "./loginService"
      .controller "loginController", require "./loginController"
      .config require "./loginConfig"

module.exports = moduleName

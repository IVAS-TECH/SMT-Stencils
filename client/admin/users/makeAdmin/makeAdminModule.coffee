{angular} = require "dependencies"
moduleName = "makeAdminModule"

angular.module moduleName, []
  .service "makeAdminService", require "./makeAdminService"
  .controller "makeAdminController", require "./makeAdminController"

module.exports = moduleName

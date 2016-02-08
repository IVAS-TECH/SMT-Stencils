{angular} = require "dependencies"
moduleName = "usersModule"

angular.module moduleName, [require "./makeAdmin/makeAdminModule"]
  .controller "usersController", require "./usersController"

module.exports = moduleName

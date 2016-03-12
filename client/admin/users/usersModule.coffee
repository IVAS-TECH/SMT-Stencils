{angular} = require "dependencies"
moduleName = "usersModule"

angular.module moduleName, [require "./changeAccess/changeAccessModule"]
  .controller "usersController", require "./usersController"

module.exports = moduleName
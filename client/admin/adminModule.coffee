{angular} = require "dependencies"
moduleName = "adminModule"

angular
  .module moduleName, []
    .controller "adminController", require "./adminController"
    .config require "./adminConfig"

module.exports = moduleName

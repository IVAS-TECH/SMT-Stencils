{angular} = require "dependencies"
moduleName = "helperModule"

angular
  .module moduleName, []
    .provider "template", require "./templateProvider"
    .service "stateSwitcherService", require "./stateSwitcherService"

module.exports = moduleName

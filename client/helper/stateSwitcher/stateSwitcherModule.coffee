{angular} = require "dependencies"
moduleName = "stateSwitcherModule"

angular
  .module moduleName, []
    .service "stateSwitcherService", require "./stateSwitcherService"
    .controller "stateSwitcherController", require "./stateSwitcherController"
    .directive "ivoStateSwitcher", require "./stateSwitcherDirective"

module.exports = moduleName

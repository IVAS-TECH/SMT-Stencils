{angular} = require "dependencies"
moduleName = "stateSwitcherModule"

angular.module moduleName, []
  .controller "stateSwitcherController", require "./stateSwitcherController"
  .directive "ivoStateSwitcher", require "./stateSwitcherDirective"

module.exports = moduleName

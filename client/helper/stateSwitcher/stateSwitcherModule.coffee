{angular} = require "dependencies"
moduleName = "stateSwitcherModule"

angular.module moduleName, []
  .controller "stateSwitcherController", require "./stateSwitcherController"
  .directive "ivstStateSwitcher", require "./stateSwitcherDirective"

module.exports = moduleName

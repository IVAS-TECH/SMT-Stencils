{angular} = require "dependencies"
moduleName = "stateSwitcherModule"

angular.module moduleName, []
  .factory "statesForStateService", require "./statesForStateService"
  .controller "stateSwitcherController", require "./stateSwitcherController"
  .directive "ivstStateSwitcher", require "./stateSwitcherDirective"

module.exports = moduleName

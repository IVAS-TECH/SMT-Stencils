{angular} = require "dependencies"
moduleName = "helperModule"

dependencies = [
  require "./REST/RESTModule"
]

angular
  .module moduleName, dependencies
    .provider "template", require "./templateProvider"
    .factory "RESTHelperService", require "./RESTHelperService"
    .directive "ivoStateSwitcher", require "./stateSwitcher/stateSwitcherDirective"
    .provider "translate", require "./translateProvider"
    .factory "showDialogService", require "./showDialogService"

module.exports = moduleName

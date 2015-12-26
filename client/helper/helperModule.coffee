{angular} = require "dependencies"
moduleName = "helperModule"

angular
  .module moduleName, [require "./REST/RESTModule"]
    .provider "template", require "./templateProvider"
    .provider "translate", require "./translateProvider"
    .provider "uploadService", require "./uploadService"
    .factory "showDialogService", require "./showDialogService"
    .directive "ivoStateSwitcher", require "./stateSwitcher/stateSwitcherDirective"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "helperModule"

angular
  .module moduleName, [require "./REST/RESTModule"]
    .provider "template", require "./templateProvider"
    .provider "translate", require "./translateProvider"
    .factory "RESTHelperService", require "./RESTHelperService"
    .factory "showDialogService", require "./showDialogService"
    .factory "uploadService", require "./uploadService"
    .directive "ivoStateSwitcher", require "./stateSwitcher/stateSwitcherDirective"

module.exports = moduleName

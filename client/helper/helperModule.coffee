{angular} = require "dependencies"
moduleName = "helperModule"

dependencies = [
  require "./REST/RESTModule"
  require "./stateSwitcher/stateSwitcherModule"
]

angular
  .module moduleName, dependencies
    .provider "template", require "./templateProvider"
    .factory "RESTHelperService", require "./RESTHelperService"
    .provider "translate", require "./translateProvider"
    .factory "showDialogService", require "./showDialogService"

module.exports = moduleName

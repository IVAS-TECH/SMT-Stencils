{angular} = require "dependencies"
moduleName = "helperModule"

deps = [
  require "./REST/RESTModule"
  require "./stateSwitcher/stateSwitcherModule"
]

angular
  .module moduleName, deps
    .provider "template", require "./templateProvider"
    .provider "translate", require "./translateProvider"
    .provider "uploadService", require "./uploadService"
    .factory "showErrorService", require "./showErrorService"
    .factory "showDialogService", require "./showDialogService"

module.exports = moduleName

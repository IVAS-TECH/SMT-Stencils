{angular} = require "dependencies"
moduleName = "helperModule"

deps = [
  require "./REST/RESTModule"
  require "./stateSwitcher/stateSwitcherModule"
]

angular
  .module moduleName, deps
    .provider "translate", require "./translateProvider"
    .provider "uploadService", require "./uploadServiceProvider"
    .factory "showDialogService", require "./showDialogService"
    .filter "isntEmpty", require "./isntEmptyFilter"

module.exports = moduleName

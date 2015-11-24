{angular} = require "dependencies"
moduleName = "helperModule"

angular
  .module moduleName, [require "./REST/RESTModule"]
    .provider "template", require "./templateProvider"
    .service "stateSwitcherService", require "./stateSwitcherService"
    .factory "RESTHelperService", require "./RESTHelperService"

module.exports = moduleName

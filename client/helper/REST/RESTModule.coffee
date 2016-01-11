{angular} = require "dependencies"
moduleName = "RESTModule"

angular
  .module moduleName, []
    .factory "errorHandleService", require "./errorHandleService"
    .factory "RESTHelperService", require "./RESTHelperService"
    .provider "REST", require "./RESTProvider"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "RESTModule"

angular
  .module moduleName, []
    .provider "REST", require "./RESTProvider"
    .provider "RESTHelperService", require "./RESTHelperServiceProvider"
    .factory "errorHandleService", require "./errorHandleService"

module.exports = moduleName

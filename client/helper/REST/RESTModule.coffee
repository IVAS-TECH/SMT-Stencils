{angular} = require "dependencies"
moduleName = "RESTModule"

angular.module moduleName, []
  .provider "RESTService", require "./RESTServiceProvider"
  .provider "RESTHelperService", require "./RESTHelperServiceProvider"
  .factory "errorHandleService", require "./errorHandleService"

module.exports = moduleName

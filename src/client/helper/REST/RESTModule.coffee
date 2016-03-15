{angular} = require "dependencies"
moduleName = "RESTModule"

angular.module moduleName, []
  .provider "RESTService", require "./RESTServiceProvider"
  .provider "RESTHelperService", require "./RESTHelperServiceProvider"
  .provider "errorHandleService", require "./errorHandleServiceProvider"

module.exports = moduleName

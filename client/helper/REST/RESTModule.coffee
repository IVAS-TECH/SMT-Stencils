{angular} = require "dependencies"
moduleName = "RESTModule"

angular
  .module moduleName, []
    .factory "RESTHelperService", require "./RESTHelperService"
    .provider "REST", require "./RESTProvider"

module.exports = moduleName

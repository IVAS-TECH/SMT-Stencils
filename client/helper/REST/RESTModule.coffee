{angular} = require "dependencies"
moduleName = "RESTModule"

angular
  .module moduleName, []
    .provider "REST", require "./RESTProvider"

module.exports = moduleName

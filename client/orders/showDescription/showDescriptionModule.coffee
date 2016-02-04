{angular} = require "dependencies"
moduleName = "showDescriptionModule"

angular
  .module moduleName, []
    .factory "showDescriptionService", require "./showDescriptionService"
    .controller "showDescriptionController", require "./showDescriptionController"

module.exports = moduleName

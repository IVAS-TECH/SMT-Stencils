{angular} = require "dependencies"
moduleName = "showDescriptionModule"

angular
  .module moduleName, []
    .factory "dialogWithNoDefaultHandleService", require "./dialogWithNoDefaultHandleService"
    .factory "showDescriptionService", require "./showDescriptionService"
    .controller "showDescriptionController", require "./showDescriptionController"

module.exports = moduleName

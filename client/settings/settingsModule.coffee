{angular} = require "dependencies"
moduleName = "settingsModule"

angular
    .module moduleName, [require "./profile/profileModule"]
      .controller "configurationsController", require "./configurations/configurationsController"
      .config require "./settingsConfig"

module.exports = moduleName

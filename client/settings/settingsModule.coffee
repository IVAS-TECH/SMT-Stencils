{angular} = require "dependencies"
moduleName = "settingsModule"

angular
    .module moduleName, []
      .config require "./settingsConfig"

module.exports = moduleName

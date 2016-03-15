{angular} = require "dependencies"
moduleName = "settingsModule"

angular.module moduleName, [require "./profile/profileModule"]
    .config require "./settingsConfig"

module.exports = moduleName

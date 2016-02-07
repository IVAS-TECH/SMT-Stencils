{angular} = require "dependencies"
moduleName = "showCalculatedPrice"

angular.module moduleName, []
  .factory "showCalculatedPriceService", require "./showCalculatedPriceService"
  .controller "showCalculatedPriceController", require "./showCalculatedPriceController"

module.exports = moduleName

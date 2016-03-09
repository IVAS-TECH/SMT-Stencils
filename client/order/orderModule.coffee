{angular} = require "dependencies"
moduleName = "orderModule"

dependencies = [
  require "./addresses/addressesModule"
  require "./specific/specificModule"
  require "./configuration/configurationModule"
  require "./finalizate/finalizateModule"
  require "./priceInfo/priceInfoModule"
]

angular.module moduleName, dependencies
  .constant "listOfPrices", require "./listOfPrices"
  .factory "orderPriceCalculatorService", require "./orderPriceCalculatorService"
  .controller "orderController", require "./orderController"
  .config require "./orderConfig"

module.exports = moduleName
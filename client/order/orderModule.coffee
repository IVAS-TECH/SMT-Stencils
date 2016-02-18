{angular} = require "dependencies"
moduleName = "orderModule"

dependencies = [
  require "./addresses/addressesModule"
  require "./specific/specificModule"
  require "./configuration/configurationModule"
  require "./finalizate/finalizateModule"
]

angular.module moduleName, dependencies
  .factory "orderPriceCalculatorService", require "./orderPriceCalculatorService"
  .controller "orderController", require "./orderController"
  .directive "ivoPriceInfo", require "./priceInfo/priceInfoDirective"
  .config require "./orderConfig"

module.exports = moduleName

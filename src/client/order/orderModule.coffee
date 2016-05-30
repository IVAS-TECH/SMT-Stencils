{angular} = require "dependencies"
moduleName = "orderModule"

dependencies = [
    require "./addresses/addressesModule"
    require "./specific/specificModule"
    require "./configuration/configurationModule"
    require "./finalizate/finalizateModule"
    require "./priceInfo/priceInfoModule"
]

noController = ->

angular.module moduleName, dependencies
    .constant "listOfPrices", require "./listOfPrices"
    .factory "orderPriceCalculatorService", require "./orderPriceCalculatorService"
    .factory "transitionFromOrderService", require "./transitionFromOrder/transitionFromOrderService"
    .controller "orderController", require "./orderController"
    .controller "transitionFromOrderController", noController
    .config require "./orderConfig"
    .run require "./orderRun"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "orderPayModule"

deps = [
    require "./payWithPaypal/payWithPaypalModule"
    require "./payWithStripe/payWithStripeModule"
]

noController = ->

angular.module moduleName, deps
    .factory "orderPayService", require "./orderPayService"
    .controller "orderPayController", noController

module.exports = moduleName

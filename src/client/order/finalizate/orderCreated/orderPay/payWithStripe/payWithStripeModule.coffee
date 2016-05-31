{angular} = require "dependencies"
moduleName = "payWithStripeModule"

noController = ->

angular.module moduleName, []
    .factory "payWithStripeService", require "./payWithStripeService"
    .controller "payWithStripeController", noController

module.exports = moduleName

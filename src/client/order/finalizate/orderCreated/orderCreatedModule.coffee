{angular} = require "dependencies"
moduleName = "orderCreatedModule"

angular.module moduleName, [require "./orderPay/orderPayModule"]
    .factory "orderCreatedService", require "./orderCreatedService"
    .controller "orderCreatedController", require "./orderCreatedController"

module.exports = moduleName

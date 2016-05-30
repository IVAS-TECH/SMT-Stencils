{angular} = require "dependencies"
moduleName = "finalizateModule"

angular.module moduleName, [require "./orderCreated/orderCreatedModule"]
    .directive "ivstViewOrder", require "./viewOrder/viewOrderDirective"

module.exports = moduleName

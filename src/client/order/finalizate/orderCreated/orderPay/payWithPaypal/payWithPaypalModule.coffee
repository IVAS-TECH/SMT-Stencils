{angular} = require "dependencies"
moduleName = "payWithPaypalModule"

noController = ->

angular.module moduleName, []
    .factory "payWithPaypalService", require "./payWithPaypalService"
    .controller "payWithPaypalController", noController

module.exports = moduleName

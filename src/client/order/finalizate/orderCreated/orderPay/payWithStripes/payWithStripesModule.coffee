{angular} = require "dependencies"
moduleName = "payWithStripesModule"

noController = ->

angular.module moduleName, []
    .factory "payWithStripesService", require "./payWithStripesService"
    .controller "payWithStripesController", noController

module.exports = moduleName

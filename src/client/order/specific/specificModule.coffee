{angular} = require "dependencies"
moduleName = "specificModule"

dependencies = [
    require "./orderTexts/orderTextsModule"
    require "./files/filesModule"
]

angular.module moduleName, dependencies
    .controller "specificController", require "./specificController"
    .directive "ivstOrderSpecific", require "./orderSpecific/orderSpecificDirective"
    .directive "ivstOrderPreview", require "./orderPreview/orderPreviewDirective"
    .config require "./specificConfig"

module.exports = moduleName

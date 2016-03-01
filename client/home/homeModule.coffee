{angular} = require "dependencies"
moduleName = "homeModule"

angular.module moduleName, [require './user/userModule']
  .factory "transitionService", require "./transitionService"
  .factory "stopLoadingService", require "./stopLoadingService"
  .controller "homeController", require "./homeController"
  .directive "ivoToolbar", require "./toolbar/toolbarDirective"
  .config require "./homeConfig"
  .run require "./homeRun"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "homeModule"

angular
    .module moduleName, [require './user/userModule']
      .factory "transitionService", require "./transitionService"
      .controller "homeController", require "./homeController"
      .config require "./homeConfig"

module.exports = moduleName

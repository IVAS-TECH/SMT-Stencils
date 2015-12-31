{angular} = require "dependencies"
moduleName = "homeModule"

angular
    .module moduleName, [require './user/userModule']
      .factory "goHomeService", require "./goHomeService"
      .factory "goAdminService", require "./goAdminService"
      .controller "homeController", require "./homeController"
      .config require "./homeConfig"

module.exports = moduleName

{angular} = require "dependencies"
moduleName = "homeModule"

angular
    .module moduleName, [require './user/userModule']
      .controller "homeController", require "./homeController"
      .factory "goHomeService", require "./goHomeService"
      .config require "./homeConfig"

module.exports = moduleName

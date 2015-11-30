{angular} = require "dependencies"
moduleName = "homeModule"

angular
    .module moduleName, [require './user/userModule']
      .config require "./homeConfig"
      #.run require "./homeRun"

module.exports = moduleName

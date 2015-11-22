angular = require "angular"
moduleName = "main"

dependencies = [
  require "angular-animate"
  require "angular-aria"
  require "angular-material"
  require "angular-messages"
  require "ui-router"
  require "ng-file-upload"
  require "./templateProvider"
  require "./root/rootModule"
]

angular
  .module moduleName, dependencies

angular.bootstrap document.body, [moduleName]

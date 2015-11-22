angular = require "angular"
moduleName = "main"

dependencies = [
  require "template-provider"
  require "angular-animate"
  require "angular-aria"
  require "angular-material"
  require "angular-messages"
  require "ui-router"
  require "ng-file-upload"
  require "./root/rootModule"
]

angular
  .module moduleName, dependencies

angular.bootstrap document.body, [moduleName]

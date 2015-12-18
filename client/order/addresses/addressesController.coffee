{angular} = require "dependencies"

module.exports = ($scope, progressService) ->
  controller = @
  controller.$inject = ["$scope", "progressService"]
  controller.delivery = {}
  controller.invoice = {}
  controller.firm = {}

  progress = progressService $scope, "orderCtrl", "addressesCtrl"

  controller.back = -> progress.move "specific"

  controller.next = -> progress.move "finalizate"

  controller.fill = (dst, src) ->
    angular.copy controller[dst], controller[src]

  controller

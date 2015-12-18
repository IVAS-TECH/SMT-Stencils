{angular} = require "dependencies"

module.exports = ($scope, progressService) ->
  controller = @
  controller.$inject = ["$scope", "progressService"]

  properties = [
    "delivery"
    "invoice"
    "firm"
    "sameAsAbove"
    "sameAsDelivery"
    "sameAsInvoice"
  ]

  progress = progressService $scope, "orderCtrl", "addressesCtrl", properties

  controller.back = -> progress.move "specific"

  controller.next = -> progress.move "finalizate"

  controller.fill = (dst, src) ->
    angular.copy controller[dst], controller[src]

  controller

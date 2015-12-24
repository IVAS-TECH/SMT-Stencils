module.exports = ($controller, progressService, $scope, simpleDialogService, RESTHelperService) ->
  @$inject = ["$controller", "progressService", "$scope", "simpleDialogService", "RESTHelperService"]
  injectable =
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "$scope": $scope
  properties = [
    "delivery"
    "invoice"
    "firm"
    "sameAsAbove"
    "sameAsDelivery"
    "sameAsInvoice"
  ]
  progress = progressService $scope, "orderCtrl", "addressesCtrl", properties
  controller = $controller "addressesInterface", injectable
  controller.settings = false

  controller.init = ->
    if not $scope.$parent.orderCtrl.information?
      controller.getAddresses()
    else
      stop = $scope.$on "update-view", ->
        controller.choose()
        stop()

  controller.back = -> progress.move "specific"

  controller.next = -> progress.move "finalizate"

  controller.create = (event, invalid) ->
    if controller.saveIt and not invalid
      controller.save()

  controller.init()

  controller

module.exports = ($controller, progressService, $scope, simpleDialogService, RESTHelperService, infoOnlyService) ->
  @$inject = ["$controller", "progressService", "$scope", "simpleDialogService", "RESTHelperService", "infoOnlyService"]
  injectable =
    "infoOnlyService": infoOnlyService
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "$scope": $scope
  properties = [
    "information"
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

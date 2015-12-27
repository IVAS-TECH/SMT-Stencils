module.exports = ($controller, progressService, $scope, simpleDialogService, RESTHelperService, infoOnlyService) ->
  @$inject = ["$controller", "progressService", "$scope", "simpleDialogService", "RESTHelperService", "infoOnlyService"]
  injectable =
    "infoOnlyService": infoOnlyService
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "$scope": $scope
  properties = [
    "address"
    "listOfAddresses"
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

  controller.back = -> progress "specific"

  controller.next = (event) ->
    if (controller.invalid.every (element) -> element is false)
      if controller.saveIt then controller.save()
      progress "finalizate"
    else simpleDialogService event, "required-fields"

  controller.init()

  controller

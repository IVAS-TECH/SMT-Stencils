module.exports = ($controller, $scope, RESTHelperService) ->
  @$inject = ["$controller", "$scope", "RESTHelperService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService

  controller = $controller "ordersInterface", injectable

  controller.panel = "adminPanelView"

  controller.status = [
    "__new__"
    "__accepted__"
    "__rejected__"
    "__done__"
    "__sent__"
    "__delivered__"
    "__$remove$__"
    "__$delete$__"
    "__$block$__"
  ]

  controller.addDiscription = (order) ->
    controller.choose order
    controller.order = order

  controller.update = ->
    console.log controller.discription

  controller

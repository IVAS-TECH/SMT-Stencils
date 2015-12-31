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

  controller

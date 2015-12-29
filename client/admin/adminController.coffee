module.exports = ($controller, $scope, RESTHelperService) ->
  @$inject = ["$controller", "$scope", "RESTHelperService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService

  controller = $controller "ordersInterface", injectable

  controller.panel = "adminPanelView"

  controller.status = ["new", "delivered"]

  controller

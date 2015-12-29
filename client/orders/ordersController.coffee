module.exports = ($controller, $scope, RESTHelperService) ->
  @$inject = ["$controller", "$scope", "RESTHelperService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService

  controller = $controller "ordersInterface", injectable

  controller.panel = "notAdminPanelView"

  controller

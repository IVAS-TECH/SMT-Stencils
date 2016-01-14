module.exports = ($controller, $scope, RESTHelperService, simpleDialogService, progressService, confirmService) ->
  @$inject = ["$controller", "$scope", "RESTHelperService", "simpleDialogService", "progressService", "confirmService"]

  injectable =
    "$controller": $controller
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "progressService": progressService
    "confirmService": confirmService

  controller = $controller "addressesInterface", injectable

  controller.restore()

  controller

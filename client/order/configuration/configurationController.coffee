module.exports = ($controller, template, $scope, RESTHelperService, simpleDialogService, progressService, confirmService) ->
  @$inject = ["$controller", "template", "$scope", "RESTHelperService", "simpleDialogService", "progressService", "confirmService"]

  injectable =
    "$controller": $controller
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "template": template
    "progressService": progressService
    "confirmService": confirmService

  controller = $controller "configurationInterface", injectable

  controller.restore()

  controller

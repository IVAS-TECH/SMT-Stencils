module.exports = ($controller, progressService, template, $scope, RESTHelperService, simpleDialogService) ->
  @$inject = ["$controller", "progressService", "template", "$scope", "RESTHelperService", "simpleDialogService"]

  injectable =
    "$controller": $controller
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "template": template
    "progressService": progressService

  controller = $controller "configurationInterface", injectable

  controller.restore()

  controller

module.exports = module.exports = ($controller, progressService, $scope, RESTHelperService, simpleDialogService, template) ->
  @inject = ["$controller", "progressService", "$scope", "RESTHelperService", "simpleDialogService", "template"]

  properties = ["configuration", "configs", "config", "disabled", "action"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "template": template

  progress = progressService $scope, "orderCtrl", "configCtrl", properties

  controller = $controller "configurationInterface", injectable

  controller.settings = false

  controller.init = ->
    if not $scope.$parent.orderCtrl.config?
      controller.getConfigs()
    else
      stop = $scope.$on "update-view", ->
        controller.choose()
        stop()

  controller.next = -> progress "specific"

  controller.create = ->
    if controller.saveIt
      controller.save()
    controller.next()

  controller.init()

  controller

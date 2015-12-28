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

  controller.next = (event) ->
    if not controller.invalid
      if controller.saveIt
        controller.save().then ->
          progress "specific"
      else progress "specific"
    else simpleDialogService event, "required-fields"

  controller.init()

  controller

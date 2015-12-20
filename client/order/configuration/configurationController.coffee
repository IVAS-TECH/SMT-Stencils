module.exports = module.exports = ($controller, progressService, RESTHelperService, simpleDialogService, $state, $scope, template) ->
  @inject = [
    "$controller"
    "progressService"
    "RESTHelperService"
    "simpleDialogService"
    "$state"
    "$scope"
    "template"
  ]
  injectable =
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "$state": $state
    "$scope": $scope
    "template": template
  properties = [
    "configuration"
    "configs"
    "config"
    "disabled"
    "action"
  ]
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

  controller.next = -> progress.move "specific"

  controller.create = ->
    if controller.save
      RESTHelperService.config.create config: controller.configuration, (res) ->
        if res.success then controller.configuration._id = res._id
      controller.next()

  controller.init()

  controller

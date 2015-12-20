module.exports = module.exports = ($controller, confirmService, RESTHelperService, simpleDialogService, $state, $scope, template) ->
  @inject = [
    "$controller"
    "confirmService"
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
  controller = $controller "configurationInterface", injectable
  controller.settings = true

  controller.init = -> controller.getConfigs()

  controller.create = -> controller.save()

  controller.delete = (event) ->
      confirmService event, success: ->
        RESTHelperService.config.delete controller.configuration._id, (res) ->
          controller.reset()
          $scope.$digest()

  controller.update = (event) ->
    confirmService event, success: ->
      RESTHelperService.config.update config: controller.configuration, (res) ->

  controller.init()

  controller

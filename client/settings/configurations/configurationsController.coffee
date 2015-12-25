module.exports = module.exports = ($controller, confirmService, RESTHelperService, simpleDialogService, template) ->
  @inject = [
    "$controller"
    "confirmService"
    "RESTHelperService"
    "simpleDialogService"
    "template"
  ]
  injectable =
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "template": template
  controller = $controller "configurationInterface", injectable
  controller.settings = true

  controller.init = -> controller.getConfigs()

  controller.create = -> controller.save()

  controller.edit = ->
    controller.disabled = false
    controller.action = "edit"

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
module.exports = (showErrorService, confirmService, RESTHelperService, simpleDialogService) ->
  @$inject = ["showErrorService", "confirmService", "RESTHelperService", "simpleDialogService"]

  controller = @

  controller.error = showErrorService

  controller.change = (event, type, valid) ->
    if valid
      confirmService event, success: ->
        RESTHelperService.profile type: type, value: controller.user[type], (res) ->
          simpleDialogService event, "title-changed-#{type}"

  controller

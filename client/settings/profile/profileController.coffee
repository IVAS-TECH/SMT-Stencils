module.exports = (showErrorService, confirmService, RESTHelperService, simpleDialogService) ->
  @$inject = ["showErrorService", "confirmService", "RESTHelperService", "simpleDialogService"]

  controller = @

  controller.error = showErrorService

  controller.change = (event, type, valid) ->
    if valid
      confirmService event, success: ->
        RESTHelperService.user.profile type: type, value: controller.user[type], (res) ->
          simpleDialogService event, "title-changed-#{type}"

  controller.remove = (event) ->
    confirmService event, success: ->
      RESTHelperService.user.remove "id", (res) ->
        simpleDialogService event, "title-deleted"

  controller

module.exports = (confirmService, RESTHelperService, simpleDialogService) ->
  @$inject = ["confirmService", "RESTHelperService", "simpleDialogService"]

  controller = @

  controller.change = (event, type, valid) ->
    if valid
      confirmService event, success: ->
        RESTHelperService.profile type: type, value: controller.user[type], (res) ->
          simpleDialogService event, "title-changed-#{type}"

  controller

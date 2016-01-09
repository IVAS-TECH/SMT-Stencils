module.exports = (confirmService, RESTHelperService, simpleDialogService) ->
  @$inject = ["confirmService", "RESTHelperService", "simpleDialogService"]

  controller = @

  controller.error = email: false, password: true

  controller.change = (event, type, invalid) ->
    if not invalid
      confirmService event, success: ->
        RESTHelperService.profile type: type, value: controller.user[type], (res) ->
          simpleDialogService event, "title-changed-#{type}"
    else controller.error[type] = true
      
  controller

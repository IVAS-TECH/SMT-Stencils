module.exports = (confirmService, RESTHelperService, simpleDialogService) ->
  controller = @
  controller.$inject = ["confirmService", "RESTHelperService", "simpleDialogService"]
  controller.error = email: false, password: true
  controller.change = (event, type, invalid) ->
    if not invalid
      confirmService event, success: ->
        RESTHelperService.profile type: type, value: controller.user[type], (res) ->
          if res.success then simpleDialogService event, "title-changed-#{type}"
          else simpleDialogService event, "Error!"
    else controller.error[type] = true
  controller

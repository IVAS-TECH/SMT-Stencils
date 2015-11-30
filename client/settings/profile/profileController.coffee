module.exports = (confirmService, RESTHelperService, showSimpleDialogService) ->
  controller = @
  controller.$inject = ["confirmService", "RESTHelperService", "showSimpleDialogService"]
  controller.error = email: false, password: true
  controller.change = (event, type, invalid) ->
    if not invalid
      confirmService event, success: ->
        RESTHelperService.profile type: type, value: controller.user[type], (res) ->
          if res.success then showSimpleDialogService "You successfully changed your #{type}!"
          else showSimpleDialogService "Error!"
    else controller.error[type] = true
  controller

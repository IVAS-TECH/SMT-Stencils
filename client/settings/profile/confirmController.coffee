module.exports = ($mdDialog, authenticationService) ->
  controller = @
  controller.$inject = ["$mdDialog", "authenticationService"]
  controller.hide = $mdDialog.hide
  controller.error = false
  controller.key = authenticationService.user.password
  controller.confirm = (invalid) ->
    if not invalid
      if controller.password is controller.key
        controller.hide "success"
      else controller.hide "fail"
    else controller.error = true
  controller

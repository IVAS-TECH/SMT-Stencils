module.exports = (authenticationService) ->
  controller = @
  controller.$inject = ["authenticationService"]
  controller.error = false
  controller.key = authenticationService.getUser().password
  controller.confirm = (invalid) ->
    if not invalid
      if controller.password is controller.key
        controller.hide "success"
      else controller.hide "fail"
    else controller.error = true
  controller

module.exports = (authenticationService) ->
  @$inject = ["authenticationService"]

  controller = @

  controller.key = authenticationService.getUser().password

  controller.confirm = (valid) ->
    if valid
      if controller.password is controller.key
        controller.hide "success"
      else controller.hide "fail"

  controller

module.exports = (RESTHelperService) ->
  @$inject = ["RESTHelperService"]

  controller = @

  controller.register = (valid) ->
    if valid
      RESTHelperService.user.register user: controller.user, (res) ->
        controller.hide "success"

  controller

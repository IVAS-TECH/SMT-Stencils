module.exports = (RESTHelperService) ->
  @$inject = ["RESTHelperService"]

  controller = @
  controller.error = false

  controller.register = (invalid) ->
    if not invalid
      RESTHelperService.register user: controller.user, (res) ->
        controller.hide "success"
    else controller.error = true

  controller

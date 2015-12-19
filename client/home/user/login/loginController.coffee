module.exports = (RESTHelperService) ->
  controller = @
  controller.$inject = ["RESTHelperService"]
  controller.error = false
  controller.session = true
  controller.login = (invalid) ->
    if not invalid
      RESTHelperService.login user: controller.user, (res) ->
        if res.success
          controller.hide success: user: controller.user, session: controller.session
        else controller.hide "fail"
    else controller.error = true
  controller

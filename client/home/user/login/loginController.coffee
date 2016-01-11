module.exports = (RESTHelperService) ->
  @$inject = ["RESTHelperService"]

  controller = @
  controller.session = true

  controller.login = (valid) ->
    if valid
      RESTHelperService.login user: controller.user, (res) ->
        if res.login
          controller.hide
            "success":
              user: controller.user
              session: controller.session
              admin: res.admin
        else controller.hide "fail"

  controller

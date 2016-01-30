module.exports = (RESTHelperService) ->
  @$inject = ["RESTHelperService"]

  controller = @
  controller.session = yes

  controller.login = (valid) ->
    if valid
      RESTHelperService.login.login user: controller.user, (res) ->
        if res.login
          controller.hide
            "login": null
            "success":
              user: controller.user
              session: controller.session
              admin: res.admin
        else controller.hide "fail"

  controller

module.exports = (action) ->
  ($mdDialog, RESTHelperService) ->
    controller = @
    controller.$inject = ["$mdDialog", "RESTHelperService"]
    controller.hide = $mdDialog.hide
    if action?
      controller.error = false
      if action is "login"
        controller.session = true
        controller.login = (invalid) ->
          if not invalid
            RESTHelperService.login user: controller.user, session: controller.session, (res) ->
              if res.success then controller.hide success: controller.user else controller.hide "fail"
          else controller.error = true
      else
        controller.register = (invalid) ->
          if not invalid
            RESTHelperService.register user: controller.user, (res) ->
              if res.success then controller.hide "success" else controller.hide "fail"
          else controller.error = true
    controller

module.exports = (action) ->
  ($mdDialog, RESTHelperService) ->
    controller = @
    controller.$inject = ["$mdDialog", "RESTHelperService"]
    controller.hide = $mdDialog.hide
    if action?
      controller.error = false
      if action is "login"
        controller.session = true
        controller[action] = (invalid) ->
          if not invalid
            RESTHelperService[action] user: controller.user, session: controller.session, (res) ->
              if res.success then controller.hide success: controller.user else controller.hide "fail"
          else controller.error = true
      else
        controller[action] = (invalid) ->
          if not invalid
            RESTHelperService[action] user: controller.user, (res) ->
              if res.success then controller.hide "success" else controller.hide "fail"
    controller

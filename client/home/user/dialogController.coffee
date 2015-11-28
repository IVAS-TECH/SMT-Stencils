module.exports = (action) ->
  ($mdDialog, RESTHelperService) ->
    controller = @
    controller.$inject = ["$mdDialog", "RESTHelperService"]
    controller.hide = $mdDialog.hide
    if action?
      controller.error = false
      controller[action] = (invalid) ->
        if not invalid
          RESTHelperService[action] user: controller.user, (res) ->
            success = if action is "login" then success: controller.user else "success"
            if res.success then controller.hide success else controller.hide "fail"
        else controller.error = true
    controller

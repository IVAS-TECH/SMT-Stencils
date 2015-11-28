module.exports = ($mdDialog, RESTHelperService) ->
  controller = @
  controller.$inject = ["$mdDialog", "RESTHelperService"]
  controller.hide = $mdDialog.hide
  controller.error = false
  controller.register = (invalid) ->
    if not invalid
      RESTHelperService.register controller.user, (res) ->
        if res.success then controller.hide "success" else controller.hide "fail"
    else controller.error = true
  controller

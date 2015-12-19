module.exports = (RESTHelperService) ->
  controller = @
  controller.$inject = ["RESTHelperService"]
  controller.error = false
  controller.register = (invalid) ->
    if not invalid
      RESTHelperService.register user: controller.user, (res) ->
        if res.success then controller.hide "success" else controller.hide "fail"
    else controller.error = true
  controller

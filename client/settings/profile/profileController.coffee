module.exports = (RESTHelperService) ->
  controller = @
  controller.$inject = ["RESTHelperService"]
  controller.error = email: false, password: true
  controller.change = (event, type, invalid) ->
    if not invalid
      RESTHelperService.profile type: type, value: controller.user[type], (res) ->
        ###if res.success then showSipleDialog "You successfully changed your #{type}!"
        else showSipleDialog "Error!"###
    else controller.error[type] = true
  controller

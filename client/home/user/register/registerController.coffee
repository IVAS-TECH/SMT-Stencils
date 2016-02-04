controller = (RESTHelperService) ->

  ctrl = @

  ctrl.register = (valid) ->
    if valid
      RESTHelperService.user.register user: ctrl.user, (res) ->
        ctrl.hide "success"

  ctrl

controller.$inject = ["RESTHelperService"]

module.exports = controller

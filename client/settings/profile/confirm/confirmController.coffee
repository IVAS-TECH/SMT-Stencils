controller = (authenticationService) ->

  ctrl = @

  ctrl.key = authenticationService.getUser().password

  ctrl.confirm = (valid) ->
    if valid
      if ctrl.password is ctrl.key
        ctrl.hide "success"
      else ctrl.hide "fail"

  ctrl

controller.$inject = ["authenticationService"]

module.exports = controller

controller = ($translate, RESTHelperService) ->

  ctrl = @

  ctrl.register = (valid) ->
    if valid
      ctrl.user.language = $translate.use()
      RESTHelperService.user.register user: ctrl.user, (res) ->
        ctrl.hide "success"

  ctrl

controller.$inject = ["$translate", "RESTHelperService"]

module.exports = controller

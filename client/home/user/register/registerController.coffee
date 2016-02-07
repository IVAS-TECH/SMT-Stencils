controller = ($translate, RESTHelperService) ->

  ctrl = @

  ctrl.register = (valid) ->
    if valid
      send = user: ctrl.user, language: $translate.use()
      RESTHelperService.user.register send, (res) ->
        ctrl.hide "success"

  ctrl

controller.$inject = ["$translate", "RESTHelperService"]

module.exports = controller

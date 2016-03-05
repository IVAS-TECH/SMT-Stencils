controller = (RESTHelperService) ->

  ctrl = @
  ctrl.session = yes

  ctrl.login = (valid) ->
    if valid then RESTHelperService.login.login user: ctrl.user, (res) ->
      login = -> ctrl.hide login: null, success: user: res.user, session: ctrl.session
      if res.login then login() else ctrl.hide "fail"

  ctrl

controller.$inject = ["RESTHelperService"]

module.exports = controller

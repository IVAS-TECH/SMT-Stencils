controller = (RESTHelperService) ->

  ctrl = @
  ctrl.session = yes

  ctrl.login = (valid) ->
    if valid
      RESTHelperService.login.login user: ctrl.user, (res) ->
        if res.login
          ctrl.hide
            "login": null
            "success":
              user: res.user
              session: ctrl.session
        else ctrl.hide "fail"

  ctrl

controller.$inject = ["RESTHelperService"]

module.exports = controller

Promise = require "promise"
module.exports = (authenticationService, loginService) ->
  controller = @
  controller.$inject = ["authenticationService", "loginService"]
  home = -> $state.go "home.about"
  controller.switchState = (state) ->
    new Promise (resolve, reject) ->
      if state not in ["about", "technologies", "contacts"] and not authenticationService.authenticated
        loginService()
        if authenticationService.authenticated then resolve()
        else reject()
      else resolve()
  controller

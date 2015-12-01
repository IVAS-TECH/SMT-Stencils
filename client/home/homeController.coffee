Promise = require "promise"
module.exports = (authenticationService, loginService, goHomeService) ->
  controller = @
  controller.$inject = ["authenticationService", "loginService", "goHomeService"]
  controller.switchState = (state) ->
    new Promise (resolve, reject) ->
      if state not in ["about", "technologies", "contacts"] and not authenticationService.authenticated
        loginService {}, close: goHomeService, cancel: goHomeService
        if authenticationService.authenticated then resolve()
        else reject()
      else resolve()
  controller

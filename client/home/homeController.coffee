Promise = require "promise"
module.exports = (authenticationService, $location, $state, $scope, loginService) ->
  controller = @
  controller.$inject = ["authenticationService", "$location", "$state", $scope, "loginService"]
  home = -> $state.go "home.about"
  controller.switchState = (state) ->
    new Promise (resolve, reject) ->
      if state not in ["about", "technologies", "contacts"] and not authenticationService.authenticated
        loginService()
        if authenticationService.authenticated then resolve()
        else reject()
      else resolve()
  controller

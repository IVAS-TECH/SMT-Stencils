Promise = require "promise"
module.exports = (authenticationService, loginService, goHomeService, $location, $scope) ->
  controller = @
  controller.$inject = ["authenticationService", "loginService", "goHomeService", "$scope"]
  init = ->
    restrict = ->
      if $location.path() is "" then goHomeService()
      authenticationService.authenticate().then ->
        if $location.path() not in ["/about", "/technologies", "/contacts"] and not authenticationService.authenticated
          loginService {}, close: goHomeService, cancel: goHomeService
    restrict()
    $scope.$on "$locationChangeSuccess", restrict
  controller.switchState = (state) ->
    new Promise (resolve, reject) ->
      if state not in ["about", "technologies", "contacts"] and not authenticationService.authenticated
        loginService {}, close: goHomeService, cancel: goHomeService
        if authenticationService.authenticated then resolve()
        else reject()
      else resolve()
  init()
  controller

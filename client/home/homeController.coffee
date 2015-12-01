Promise = require "promise"
module.exports = (authenticationService, loginService, goHomeService, $location, $scope) ->
  controller = @
  controller.$inject = ["authenticationService", "loginService", "goHomeService", "$scope"]
  init = ->
    restrict = ->
      authenticationService.authenticate().then ->
        if $location.path() not in ["/about", "/technologies", "/contacts"] and not authenticationService.authenticated
          loginService {}, close: goHomeService, cancel: goHomeService
    if $location.path() is "" then goHomeService()
    restrict()
    $scope.$on "$locationChangeSuccess", restrict
  init()
  controller

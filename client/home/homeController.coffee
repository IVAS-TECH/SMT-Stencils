module.exports = (authenticationService, loginService, goHomeService, $location, $scope) ->
  controller = @
  controller.$inject = ["authenticationService", "loginService", "goHomeService", "$scope"]

  init = ->

    restrict = ->
      if not authenticationService.isAuthenticated()
        if $location.path() not in ["/about", "/technologies", "/contacts"]
          loginService {}, close: goHomeService, cancel: goHomeService

    if $location.path() is "" then goHomeService()

    authenticationService.authenticate().then ->
      restrict()
      $scope.$on "$locationChangeSuccess", restrict

  init()

  controller

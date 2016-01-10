module.exports = ($scope, $location, authenticationService, loginService, transitionService) ->
  @$inject = ["$scope", "$location", "authenticationService", "loginService", "transitionService"]

  controller = @

  init = ->

    restrict = ->

      if not authenticationService.isAuthenticated()

        if $location.path() not in ["/about", "/technologies", "/contacts"]
          loginService {},
            close: transitionService.toHome
            cancel: transitionService.toHome
      else
          controller.admin = authenticationService.isAdmin()

    if $location.path() is "" then transitionService.toHome()

    authenticationService.authenticate().then ->

      restrict()

      $scope.$on "$locationChangeStart", restrict

  init()

  controller

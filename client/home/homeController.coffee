module.exports = ($scope, $location, authenticationService, loginService, goHomeService, goAdminService) ->
  @$inject = ["$scope", "$location", "authenticationService", "loginService", "goHomeService", "goAdminService"]

  controller = @

  init = ->

    restrict = ->
      if not authenticationService.isAuthenticated()

        if authenticationService.isAdmin()
          if $location.path() isnt "/admin" then goAdminService()

        else

          if $location.path() is "/admin" then goHomeService()

          if $location.path() not in ["/about", "/technologies", "/contacts"]
            loginService {}, close: goHomeService, cancel: goHomeService

    if $location.path() is "" then goHomeService()

    authenticationService.authenticate().then ->
      restrict()
      $scope.$on "$locationChangeSuccess", restrict

  init()

  controller

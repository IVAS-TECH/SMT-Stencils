module.exports = ($scope, $window, registerService, loginService, authenticationService, transitionService) ->
  @$inject = ["$scope", "$window", "registerService", "loginService", "authenticationService", "transitionService"]

  controller = @

  authenticateUser = ->
    controller.authenticated = authenticationService.isAuthenticated()
    controller.user = authenticationService.getUser()
    if authenticationService.isAsync()
      $scope.$digest()

  init = ->

    stop = $scope.$on "authentication", ->

      authenticateUser()

      if not authenticationService.isSession()
        $window.onbeforeunload = (event) ->
          event.preventDefault()
          authenticationService.unauthenticate()
          return

    $scope.$on "$destroy", stop

  controller.register = (event) -> registerService event

  controller.login = (event) -> loginService event

  controller.logout = (event) ->
    authenticationService.unauthenticate ->
      authenticateUser()
      transitionService.toHome()

  init()

  controller

module.exports = (registerService, loginService, authenticationService, $scope, $window) ->
  controller = @
  controller.$inject = ["registerService", "loginService", "authenticationService", "$scope", "$window"]
  authenticateUser = ->
    controller.user = authenticationService.user
    controller.authenticated = authenticationService.authenticated
  controller.register = (event) -> registerService event
  controller.login = (event) -> loginService event
  controller.logout = ->
    authenticationService.unauthenticate()
    authenticateUser()
  $scope.$on "authentication", ->
    authenticateUser()
    if not authenticationService.session
      $window.onbeforeunload = (event) ->
        event.preventDefault()
        authenticationService.unauthenticate()
        return
  authenticateUser()
  controller

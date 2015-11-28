module.exports = (registerService, loginService, authenticationService, $rootScope) ->
  controller = @
  controller.$inject = ["registerService", "loginService", "authenticationService", "$rootScope"]
  controller.register = (event) -> registerService event
  controller.login = (event) -> loginService event
  authenticate = (event) ->
    if event?
      event.preventDefault()
    controller.user = authenticationService.user
    controller.authenticated = authenticationService.authenticated
  authenticate()
  if not controller.authenticated then $rootScope.$on "authentication", authenticate
  controller

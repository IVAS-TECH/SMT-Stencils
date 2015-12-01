module.exports = (registerService, loginService, authenticationService, $scope, $window, $location, goHomeService) ->
  controller = @
  controller.$inject = ["registerService", "loginService", "authenticationService", "$scope", "$window", "$location", "goHomeService"]
  authenticateUser = ->
    controller.user = authenticationService.user
    controller.authenticated = authenticationService.authenticated
  init = ->
    if $location.path() is "" then goHomeService()
    $scope.$on "authentication", ->
      authenticateUser()
      if not authenticationService.session
        $window.onbeforeunload = (event) ->
          event.preventDefault()
          authenticationService.unauthenticate()
          return
    authenticationService.authenticate().then ->
      authenticateUser()
      $scope.$digest()
      if $location.path() not in ["/about", "/technologies", "/contacts"] and not controller.authenticated
        loginService {}, close: goHomeService, cancel: goHomeService
  controller.register = (event) -> registerService event
  controller.login = (event) -> loginService event
  controller.logout = (event) ->
    authenticationService.unauthenticate()
    authenticateUser()
    goHomeService()
  init()
  controller

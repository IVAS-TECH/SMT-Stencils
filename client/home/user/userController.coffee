module.exports = (registerService, loginService, authenticationService, $scope, $window, $location, $state) ->
  controller = @
  controller.$inject = ["registerService", "loginService", "authenticationService", "$scope", "$window", "$location", "$state"]
  authenticateUser = ->
    controller.user = authenticationService.user
    controller.authenticated = authenticationService.authenticated
  controller.register = (event) -> registerService event
  controller.login = (event) -> loginService event
  controller.logout = (event) ->
    authenticationService.unauthenticate()
    authenticateUser()
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
    if $location.path() not in ["/", "/about", "/technologies", "/contacts"]
      home = -> $state.go "home.about"
      loginService {}, fail: home, close: home, cancel: home

  controller

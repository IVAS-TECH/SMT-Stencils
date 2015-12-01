module.exports = (registerService, loginService, authenticationService, $scope, $window, $location, $state) ->
  controller = @
  controller.$inject = ["registerService", "loginService", "authenticationService", "$scope", "$window", "$location", "$state"]
  authenticateUser = ->
    controller.user = authenticationService.user
    controller.authenticated = authenticationService.authenticated
  goHome = -> $state.go "home.about"
  init = ->
    if $location.path() is "" then goHome()
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
        loginService {}, close: goHome, cancel: goHome
  controller.register = (event) -> registerService event
  controller.login = (event) -> loginService event
  controller.logout = (event) ->
    authenticationService.unauthenticate()
    authenticateUser()
    goHome()
  init()
  controller

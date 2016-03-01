controller = ($scope, $window, registerService, loginService, authenticationService, transitionService) ->

  ctrl = @

  authenticateUser = ->
    ctrl.authenticated = authenticationService.isAuthenticated()
    ctrl.user = authenticationService.getUser()

  init = ->
  
    authenticateUser()
  
    stopAuth = $scope.$on "authentication", ->
    
      authenticateUser()

      if not authenticationService.isSession()
        $window.onbeforeunload = (event) ->
          event.preventDefault()
          authenticationService.unauthenticate()
          return

    stopRemove = $scope.$on "remove-account", ctrl.logout

    $scope.$on "$destroy", ->
      stopAuth()
      stopRemove()

  ctrl.register = (event) -> registerService event

  ctrl.login = (event) -> loginService event

  ctrl.logout = (event) ->
    authenticationService.unauthenticate ->
      authenticateUser()
      transitionService.toHome()

  init()

  ctrl

controller.$inject = ["$scope", "$window", "registerService", "loginService", "authenticationService", "transitionService"]

module.exports = controller

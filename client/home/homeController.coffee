module.exports = ($scope, $state, authenticationService, loginService, transitionService) ->
  @$inject = ["$scope", "$state", "authenticationService", "loginService", "transitionService"]

  controller = @

  controller.admin = no

  init = ->

    restrict = (event, toState, toParams, fromState, fromParams) ->

      if not authenticationService.isAuthenticated() and toState.url not in ["/about", "/technologies", "/contacts"]

        event.preventDefault()

        loginService event,
          login: -> setTimeout (-> $state.go toState.name), 1
          close: transitionService.toHome

    if $state.current.name is "home" then transitionService.toHome()

    authenticationService.authenticate().then ->

      stopRestriction = null

      stopAuth = null

      if authenticationService.isAuthenticated()
        if authenticationService.isAdmin()
          controller.admin = yes
          $scope.$digest()
          transitionService.toAdmin()

      else
        stopAuth = $scope.$on "authentication", ->
          controller.admin = authenticationService.isAdmin()

        stopRestriction = $scope.$on "$stateChangeStart", restrict

      stopUnAuth = $scope.$on "unauthentication", -> controller.admin = no

      $scope.$on "$destroy", ->
        if stopRestriction?
          stopRestriction()
          stopAuth()
        stopUnAuth()

  init()

  controller

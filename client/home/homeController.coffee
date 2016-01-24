module.exports = ($scope, $state, authenticationService, loginService, transitionService, notificationService) ->
  @$inject = ["$scope", "$state", "authenticationService", "loginService", "transitionService", "notificationService"]

  controller = @

  controller.admin = no

  init = ->

    becomeAdmin = ->
      if authenticationService.isAdmin()
        controller.admin = yes
        transitionService.toAdmin()
        $scope.$digest()

    restrict = (event, toState, toParams, fromState, fromParams) ->

      if not authenticationService.isAuthenticated() and toState.url not in ["/about", "/technologies", "/contacts"]

        event.preventDefault()

        proceed = ->
          becomeAdmin()
          if not controller.admin
            $state.go toState.name

        loginService event,
          login: -> setTimeout proceed, 1
          close: transitionService.toHome

      else becomeAdmin()

    if $state.current.name is "home" then transitionService.toHome()

    authenticationService.authenticate().then ->

      stopRestriction = null

      stopAuth = null

      if authenticationService.isAuthenticated() then becomeAdmin()

      else
        stopAuth = $scope.$on "authentication", ->
          controller.admin = authenticationService.isAdmin()

        stopRestriction = $scope.$on "$stateChangeStart", restrict

      stopUnAuth = $scope.$on "unauthentication", -> controller.admin = no

      stopNotifing = notificationService.listenForNotification()

      $scope.$on "$destroy", ->
        if stopRestriction?
          stopRestriction()
          stopAuth()
        stopUnAuth()
        clearTimeout stopNotifing

  init()

  controller

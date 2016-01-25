module.exports = ($scope, $state, authenticationService, loginService, transitionService, notificationService) ->
  @$inject = ["$scope", "$state", "authenticationService", "loginService", "transitionService", "notificationService"]

  controller = @

  controller.admin = no

  init = ->

    if $state.current.name is "home" then transitionService.toHome()

    authenticationService.authenticate().then ->

      becomeAdmin = ->
        controller.admin = authenticationService.isAdmin()
        if controller.admin
          transitionService.toAdmin()
        controller.admin

      stopRestriction = null

      stopAuth = null

      if authenticationService.isAuthenticated()
        if becomeAdmin() then $scope.$digest()

      else
        stopAuth = $scope.$on "authentication", becomeAdmin

        stopRestriction = $scope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->

          if not authenticationService.isAuthenticated() and toState.url not in ["/about", "/technologies", "/contacts"]

            event.preventDefault()

            loginService event,
              login: -> setTimeout (-> $state.go toState.name), 1
              close: transitionService.toHome

      stopUnAuth = $scope.$on "unauthentication", -> controller.admin = no

      notifing = notificationService.listenForNotification()

      $scope.$on "$destroy", ->
        if stopRestriction?
          stopRestriction()
          stopAuth()
        stopUnAuth()
        clearTimeout notifing

  init()

  controller

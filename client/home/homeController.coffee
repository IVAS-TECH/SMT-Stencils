controller = ($scope, $state, authenticationService, loginService, transitionService, notificationService) ->

  ctrl = @

  ctrl.admin = no

  init = ->

    stop = {}

    prevent = (event, going) ->

      notRestricted = ["/about", "/technologies", "/contacts"]

      stop.start()

      stop.success()

      if going.url not in notRestricted then event.preventDefault()

      authenticationService.authenticate().then ->

        tryBecomeAdmin = ->
          admin = ctrl.admin
          ctrl.admin = authenticationService.isAdmin()
          if ctrl.admin is admin then return admin
          if ctrl.admin then transitionService.toAdmin()
          else notificationService.reListenForNotification()
          ctrl.admin

        goTo = null

        if authenticationService.isAuthenticated()
          if not tryBecomeAdmin() then goTo = going.name
        else

          if event.defaultPrevented then loginService event,
            login: -> $state.go going.name
            close: transitionService.toHome

        stopAuth = $scope.$on "authentication", tryBecomeAdmin

        stopRestriction = $scope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->

          if not authenticationService.isAuthenticated() and toState.url not in notRestricted

            event.preventDefault()

            loginService event,
              login: -> setTimeout (-> if not tryBecomeAdmin() then $state.go toState.name), 1
              close: -> $state.go fromState.name

        stopUnAuth = $scope.$on "unauthentication", -> ctrl.admin = no

        if goTo? then $state.go goTo

        notificationService.listenForNotification()

        $scope.$on "$destroy", ->
          stopRestriction()
          stopAuth()
          stopUnAuth()
          notificationService.stopListen()

    stop.start = $scope.$on "$stateChangeStart", prevent

    stop.success = $scope.$on "$stateChangeSuccess", prevent

  init()

  ctrl

controller.$inject = ["$scope", "$state", "authenticationService", "loginService", "transitionService", "notificationService"]

module.exports = controller

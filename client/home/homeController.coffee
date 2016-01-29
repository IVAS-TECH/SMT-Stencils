module.exports = ($scope, $state, authenticationService, loginService, transitionService, notificationService) ->
  @$inject = ["$scope", "$state", "authenticationService", "loginService", "transitionService", "notificationService"]

  controller = @

  controller.admin = no

  init = ->

    if $state.current.name is "home" then transitionService.toHome()

    stop = {}

    prevent = (event, going) ->

      notRestricted = ["/about", "/technologies", "/contacts"]

      if going.url not in notRestricted then  event.preventDefault()

      stop.start()

      stop.success()

      authenticationService.authenticate().then ->

        tryBecomeAdmin = ->
          admin = controller.admin
          controller.admin = authenticationService.isAdmin()
          if controller.admin is admin then return admin
          if controller.admin then transitionService.toAdmin()
          else notificationService.reListenForNotification()
          controller.admin

        stopRestriction = null

        stopAuth = null

        goTo = null

        if authenticationService.isAuthenticated()
          if tryBecomeAdmin() then $scope.$digest()
          else goTo = going.name
        else

          if event.defaultPrevented then loginService event,
            login: -> $state.go going.name
            close: transitionService.toHome

          stopAuth = $scope.$on "authentication", tryBecomeAdmin

          stopRestriction = $scope.$on "$stateChangeStart", (event, toState) ->

            if not authenticationService.isAuthenticated() and toState.url not in notRestricted

              event.preventDefault()

              loginService event,
                login: -> setTimeout (-> if not tryBecomeAdmin() then $state.go toState.name), 1
                close: transitionService.toHome

        stopUnAuth = $scope.$on "unauthentication", -> controller.admin = no

        if goTo? then $state.go goTo

        notificationService.listenForNotification()

        $scope.$on "$destroy", ->
          if stopRestriction?
            stopRestriction()
            stopAuth()
          stopUnAuth()
          notificationService.stopListen()

    stop.start = $scope.$on "$stateChangeStart", prevent

    stop.success = $scope.$on "$stateChangeSuccess", prevent

  init()

  controller

run = ($rootScope, $state, authenticationService, loginService, transitionService, notificationService, $timeout) ->
    
    stop = $rootScope.$on "$stateChangeStart", (event, going) ->

      notRestricted = ["/about", "/technologies", "/contacts"]

      stop()
      
      force = (state) -> $state.go state.name, {}, reload: yes

      if going.url not in notRestricted then event.preventDefault()

      authenticationService.authenticate().then ->
      
        admin = no

        tryBecomeAdmin = ->
          admin = authenticationService.isAdmin()
          if admin then transitionService.toAdmin()
          else notificationService.reListenForNotification()

        goTo = no
        
        if authenticationService.isAuthenticated()
            tryBecomeAdmin()
            if not admin then goTo = yes
        else if event.defaultPrevented then loginService {},
            login: -> $timeout (-> if not admin then force going), 1
            close: transitionService.toHome

        stopAuth = $rootScope.$on "authentication", tryBecomeAdmin

        stopRestriction = $rootScope.$on "$stateChangeStart", (evnt, toState, toParams, fromState, fromParams) ->

          if not authenticationService.isAuthenticated() and toState.url not in notRestricted

            evnt.preventDefault()

            loginService {},
              login: -> $timeout (-> if not admin then force toState), 1
              close: -> force fromState

        if goTo then force going

        notificationService.listenForNotification()

        $rootScope.$on "$destroy", ->
          stopRestriction()
          stopAuth()
          notificationService.stopListen()

run.$inject = ["$rootScope", "$state", "authenticationService", "loginService", "transitionService", "notificationService", "$timeout"]

module.exports = run
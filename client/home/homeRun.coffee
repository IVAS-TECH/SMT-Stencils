run = ($rootScope, $state, authenticationService, loginService, transitionService, notificationService, $timeout, $mdDialog) ->
    
    stop = $rootScope.$on "$stateChangeStart", (event, going) ->
      notRestricted = ["/about", "/technologies", "/contacts", "/notfound"]
      admin = no
      goTo = no
      
      force = (state) -> $state.go state.name, {}, reload: yes
      
      login = (state, close) -> loginService {}, login: (-> $timeout (-> if not admin then force state), 1), close: close, cancel: close
      
      tryBecomeAdmin = ->
          admin = authenticationService.isAdmin()
          if admin then transitionService.toAdmin()
          else notificationService.listenForNotification()
      
      stop()

      if going.url not in notRestricted
        event.preventDefault()
        $mdDialog.show templateUrl: "loadingView", fullscreen: yes, hasBackdrop: no, escapeToClose: no
        stopLoading = $rootScope.$on "cancel-loading", ->
          $mdDialog.hide()
          stopLoading()

      authenticationService.authenticate().then ->
        if authenticationService.isAuthenticated()
            tryBecomeAdmin()
            if not admin then goTo = yes
        else if event.defaultPrevented then login going, transitionService.toHome

        stopAuth = $rootScope.$on "authentication", tryBecomeAdmin

        stopRestriction = $rootScope.$on "$stateChangeStart", (evnt, toState, toParams, fromState, fromParams) ->

          if not authenticationService.isAuthenticated() and toState.url not in notRestricted
            evnt.preventDefault()
            login toState

        if goTo then force going

        $rootScope.$on "$destroy", ->
          stopRestriction()
          stopAuth()
          notificationService.stopListen()

run.$inject = ["$rootScope", "$state", "authenticationService", "loginService", "transitionService", "notificationService", "$timeout", "$mdDialog"]

module.exports = run
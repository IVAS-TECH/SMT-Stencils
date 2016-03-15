describe "homeController -> init", ->

  tested = require "./../homeController"

  event = test = homeController = $scope = $state = authenticationService = loginService = transitionService = undefined

  beforeEach ->

    $scope = jasmine.createSpyObj "$scope", ["$on", "$digest"]

    $state =
      current: name: "home.about"
      go: jasmine.createSpy()

    authenticationService = jasmine.createSpyObj "authenticationService", ["isAuthenticated", "isAdmin", "authenticate"]

    authenticationService.authenticate.and.callFake -> then: (cb) -> cb()

    loginService = jasmine.createSpy()

    transitionService = jasmine.createSpyObj "transitionService", ["toHome", "toAdmin"]

    test = ->
      homeController = tested  $scope, $state, authenticationService, loginService, transitionService

    test()

    event = preventDefault: jasmine.createSpy()

  describe "when going to home because of restriction", ->

    beforeEach ->

      authenticationService.isAuthenticated.and.callFake -> no

      $scope.$on.and.callFake (evnt, cb) ->
        if evnt is "$stateChangeStart" then cb event,
          url: "/order"
          name: "home.order"

    it "should go home because of current $state is top root one", ->

      $state.current.name = "home"

      test()

      expect(transitionService.toHome).toHaveBeenCalled()

    it "should go home when user closes login dialog", ->

      loginService.and.callFake (evnt, handle) ->
        handle.close()

      test()

      expect($state.go).not.toHaveBeenCalledWith "home.order"

      expect(transitionService.toHome).toHaveBeenCalled()

    it "should change state when user successfuly logs in", ->

      loginService.and.callFake (evnt, handle) ->
        handle.login()

      test()

      expect(transitionService.toHome).not.toHaveBeenCalled()

      expect($state.go).not.toHaveBeenCalledWith "home.order"

      jasmine.clock().install()

      jasmine.clock().tick 2

      expect($state.go).not.toHaveBeenCalledWith "home.order"

      jasmine.clock().uninstall()

  describe "when not going to home and all listeners", ->

    beforeEach ->

      $scope.$on.and.callFake (evnt, cb) ->
        if evnt is "$stateChangeStart" then cb event
          url: "/contacts"
          name: "home.contacts"

      authenticationService.isAuthenticated.and.callFake -> yes

      authenticationService.isAdmin.and.callFake -> yes

    it "shouldn't open login dialog if current state isn't under restriction", ->

      expect(transitionService.toHome).not.toHaveBeenCalled()

      expect(event.preventDefault).not.toHaveBeenCalled()

      expect(loginService).not.toHaveBeenCalled()

    it "should set admin if user is authenticated and go to admin page", ->

      test()

      expect(homeController.admin).toBe yes

      expect($scope.$digest).toHaveBeenCalled()

      expect(transitionService.toAdmin).toHaveBeenCalled()

    it "shouldn't do any think if user is authenticated but it isn't admin", ->

      authenticationService.isAdmin.and.callFake -> no

      test()

      expect(homeController.admin).toBe no

      expect($scope.$digest).not.toHaveBeenCalled()

      expect(transitionService.toAdmin).not.toHaveBeenCalled()

    describe "all listeners", ->

      beforeEach ->
        authenticationService.isAuthenticated.and.callFake -> no

      it "should change admin status on 'authentication'", ->

        $scope.$on.and.callFake (evnt, cb) ->
          if evnt is "authentication" then  cb()

        test()

        expect(homeController.admin).toBe yes

      it "should set admin status to false on 'unauthentication'", ->

        $scope.$on.and.callFake (evnt, cb) ->
          if evnt is "unauthentication" then  cb()

        test()

        expect(homeController.admin).toBe no

      it "shouldn't change $state if current isn't under restriction", ->

        $scope.$on.and.callFake (evnt, cb) ->
          if evnt is "$stateChangeStart" then  cb event, url: "/about", name: "home.about"

        test()

        expect(event.preventDefault).not.toHaveBeenCalled()

        expect($state.go).not.toHaveBeenCalledWith "home.about"



  describe "when admin logouts", ->

    it "should reset admin status", ->

      $scope.$on.and.callFake (event, cb) ->
        if event is "unauthentication" then cb()

      expect(homeController.admin).toBe no

  describe "when $scope is $destroyed", ->

    stopRestriction = stopUnAuth = stopAuth = undefined

    beforeEach ->

      stopRestriction = jasmine.createSpy()

      stopUnAuth = jasmine.createSpy()

      stopAuth = jasmine.createSpy()

      $scope.$on.and.callFake (evnt, cb) ->
        switch evnt
          when "authentication" then stopAuth
          when "unauthentication" then stopUnAuth
          when "$stateChangeStart" then stopRestriction
          when "$destroy" then cb()

    it "should deregistrate all $scope listeners", ->

      test()

      expect(stopRestriction).toHaveBeenCalled()

      expect(stopUnAuth).toHaveBeenCalled()

      expect(stopAuth).toHaveBeenCalled()

    it "should deregistrate only 'unauthenticate' listener", ->

      authenticationService.isAuthenticated.and.callFake -> yes

      test()

      expect(stopRestriction).not.toHaveBeenCalled()

      expect(stopUnAuth).toHaveBeenCalled()

      expect(stopAuth).not.toHaveBeenCalled()

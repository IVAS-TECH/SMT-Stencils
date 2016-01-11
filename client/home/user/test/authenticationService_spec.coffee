describe "authenticationService", ->

  tested = require "./../authenticationService"

  authenticationService = $rootScope = RESTHelperService = transitionService = undefined

  test = ->
    authenticationService = tested.call {}, $rootScope, RESTHelperService, transitionService

  beforeEach ->

    $rootScope = jasmine.createSpyObj "$rootScope", ["$on", "$broadcast"]

    RESTHelperService = jasmine.createSpyObj "RESTHelperService", ["logged", "logout"]

    transitionService = toAdmin: jasmine.createSpy()

  describe "default behaviour", ->

    it "should be in default state", ->

      test()

      expect(authenticationService.getUser()).toBe null

      expect(authenticationService.isAuthenticated()).toBe false

      expect(authenticationService.isSession()).toBe true

      expect(authenticationService.isAsync()).toBe false

      expect(authenticationService.isAdmin()).toBe false

      expect(authenticationService.getAdminAccess()).toEqual -1

      expect(transitionService.toAdmin).not.toHaveBeenCalled()

  describe "authenticate", ->

    event = {}

    user = email: "email@email", password: "password"

    describe "when called from login dialog", ->

      auth = user: user, admin: admin: true

      beforeEach ->

        $rootScope.$on.and.callFake (evnt, cb) ->

          if evnt is "authentication"
            cb event, auth

      it "sets user, and admin if only they were set from login dialog", ->

        test()

        authenticationService.authenticate auth

        expect($rootScope.$broadcast).toHaveBeenCalledWith "authentication", auth

        expect(authenticationService.getUser()).toEqual user

        expect(authenticationService.isAuthenticated()).toBe true

        expect(authenticationService.isSession()).toBe true

        expect(authenticationService.isAsync()).toBe false

        expect(authenticationService.isAdmin()).toBe true

        expect(authenticationService.getAdminAccess()).toEqual -1

        expect(transitionService.toAdmin).toHaveBeenCalled()

    describe "when called after bootsraping to check user satus who is logged", ->

      res =
        login: true
        user: user
        session: true
        admin:
          admin: true
          access: 2

      beforeEach ->

        RESTHelperService.logged.and.callFake (cb) ->
          cb res

        $rootScope.$on.and.callFake (evnt, cb) ->

          res.async_ = true

          if evnt is "authentication"
            cb event, res

      it "sets all with the result of performing request to check login status", (done) ->

          test()

          authenticationService.authenticate().then ->

            expect($rootScope.$broadcast).toHaveBeenCalledWith "authentication", res

            expect(authenticationService.getUser()).toEqual user

            expect(authenticationService.isAuthenticated()).toBe true

            expect(authenticationService.isSession()).toBe true

            expect(authenticationService.isAsync()).toBe true

            expect(authenticationService.isAdmin()).toBe true

            expect(authenticationService.getAdminAccess()).toEqual 2

            done()

    describe "when called after bootsraping to check user satus who isn't logged", ->

      res = login: false

      beforeEach ->

        RESTHelperService.logged.and.callFake (cb) ->
            cb res

      it "shouldn't broadcast a login", (done) ->

          test()

          authenticationService.authenticate().then ->

            expect($rootScope.$broadcast).not.toHaveBeenCalled()

            done()

  describe "unauthenticate", ->

    spy = undefined

    beforeEach ->

      spy = jasmine.createSpy()

      RESTHelperService.logout.and.callFake (cb) -> cb()

      $rootScope.$on.and.callFake (evnt, cb) ->

        if evnt is "unauthentication" then cb {}

    it "logouts restoring sate but setting asyn to true", ->

      test()

      authenticationService.unauthenticate()

      expect(authenticationService.getUser()).toBe null

      expect(authenticationService.isAuthenticated()).toBe false

      expect(authenticationService.isSession()).toBe true

      expect(authenticationService.isAsync()).toBe true

      expect(authenticationService.isAdmin()).toBe false

      expect(spy).not.toHaveBeenCalled()

    it "should call provided callback after logouting", ->

      test()

      authenticationService.unauthenticate spy

      expect(spy).toHaveBeenCalled()

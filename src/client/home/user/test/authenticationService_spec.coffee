describe "authenticationService", ->

  tested = require "./../authenticationService"

  authenticationService = $rootScope = RESTHelperService = transitionService = undefined

  expectState = (state) ->

    for method, expected of state
      expect(authenticationService[method]()).toEqual expected

  beforeEach ->

    $rootScope = $broadcast: jasmine.createSpy()

    login = jasmine.createSpyObj "login", ["logged", "logout"]

    RESTHelperService = login: login

    authenticationService = tested $rootScope, RESTHelperService

  describe "default behaviour", ->

    it "should be in default state", ->

      expectState
        getUser: null
        isAuthenticated: no
        isSession: yes
        isAsync: no
        isAdmin: no
        getAdminAccess: -1

  describe "authenticate", ->

    event = {}

    user = email: "email@email", password: "password"

    describe "when called from login dialog", ->

      auth = user: user, admin: admin: true

      it "sets user, and admin if only they were set from login dialog", ->

        authenticationService.authenticate auth

        expect($rootScope.$broadcast).toHaveBeenCalledWith "authentication"

        expectState
          getUser: user
          isAuthenticated: yes
          isSession: yes
          isAsync: no
          isAdmin: yes
          getAdminAccess: -1

    describe "when called after bootsraping to check user satus who is logged", ->

      res =
        login: true
        user: user
        session: true
        admin:
          admin: true
          access: 2

      beforeEach ->

        RESTHelperService.login.logged.and.callFake (cb) ->
          cb res

      it "sets all with the result of performing request to check login status", (done) ->

          authenticationService.authenticate().then ->

            expect($rootScope.$broadcast).toHaveBeenCalledWith "authentication"

            expectState
              getUser: user
              isAuthenticated: yes
              isSession: yes
              isAsync: yes
              isAdmin: yes
              getAdminAccess: 2

            done()

    describe "when called after bootsraping to check user satus who isn't logged", ->

      res = login: false

      beforeEach ->

        RESTHelperService.login.logged.and.callFake (cb) -> cb res

      it "shouldn't broadcast a login", (done) ->

          authenticationService.authenticate().then ->

            expect($rootScope.$broadcast).not.toHaveBeenCalled()

            done()

  describe "unauthenticate", ->

    spy = undefined

    beforeEach ->

      spy = jasmine.createSpy()

      RESTHelperService.login.logout.and.callFake (cb) -> cb()

    it "logouts restoring sate but setting async to true", ->

      authenticationService.unauthenticate()

      expectState
        getUser: null
        isAuthenticated: no
        isSession: yes
        isAsync: yes
        isAdmin: no
        getAdminAccess: -1

      expect(spy).not.toHaveBeenCalled()

    it "should call provided callback after logouting", ->

      authenticationService.unauthenticate spy

      expect(spy).toHaveBeenCalled()

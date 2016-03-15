describe "userController", ->

  tested = require "./../userController"

  userController = $scope = registerService = loginService = authenticationService = transitionService = undefined

  $window = {}

  user = email: "email@email", password: "password"

  test = ->
    tested.call {}, $scope, $window, registerService, loginService, authenticationService, transitionService

  beforeEach ->

    $scope = $on: jasmine.createSpy()

    registerService = jasmine.createSpy()

    loginService = jasmine.createSpy()

    spiesFor = [
      "getUser"
      "isAuthenticated"
      "isAsync"
      "isSession"
      "unauthenticate"
    ]

    authenticationService = jasmine.createSpyObj "authenticationService", spiesFor

    authenticationService.getUser.and.callFake -> user

    authenticationService.isAuthenticated.and.callFake -> true

    transitionService = toHome: jasmine.createSpy()

  describe "-> init", ->

    stop = undefined

    beforeEach ->

      stop = jasmine.createSpy()

      $scope.$on.and.callFake (event, cb) ->
        cb()
        if event is "authentication"
          stop

    describe "init without destoing session", ->

      beforeEach ->

          authenticationService.isSession.and.callFake -> true

      it "updates user status on authentication", ->

        authenticationService.isAsync.and.callFake -> false

        userController = test()

        expect(userController.user).toEqual user

        expect(userController.authenticated).toBe true

        expect(stop).toHaveBeenCalled()

      it "re-renders userView if authentication values are comming from request", ->

        authenticationService.isAsync.and.callFake -> true

        $scope.$digest = jasmine.createSpy()

        userController = test()

        expect($scope.$digest).toHaveBeenCalled()

    describe "init with destoing session", ->

      beforeEach ->

        authenticationService.isSession.and.callFake -> false

      it "destroys session on closing the browser", ->

        userController = test()

        event = preventDefault: jasmine.createSpy()

        $window.onbeforeunload event

        expect(event.preventDefault).toHaveBeenCalled()

        expect(authenticationService.unauthenticate).toHaveBeenCalled()

  describe "controller", ->

    event = {}

    beforeEach ->
      userController = test()

    describe "register", ->

      it "registers user", ->

        userController.register event

        expect(registerService).toHaveBeenCalledWith event

    describe "login", ->

      it "logins user", ->

        userController.login event

        expect(loginService).toHaveBeenCalledWith event

    describe "logout", ->

      it "logouts user", ->

        authenticationService.unauthenticate.and.callFake (cb) -> cb()

        authenticationService.getUser.and.callFake -> null

        authenticationService.isAuthenticated.and.callFake -> false

        userController.logout event

        expect(userController.user).toBe null

        expect(userController.authenticated).toBe false

        expect(transitionService.toHome).toHaveBeenCalled()

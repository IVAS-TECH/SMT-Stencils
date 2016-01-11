describe "homeController -> init", ->

  tested = require "./../homeController"

  homeController = $scope = $location = authenticationService = loginService = transitionService = undefined

  beforeEach ->

    $scope = $on: jasmine.createSpy()

    $location = path: jasmine.createSpy()

    authenticationService = jasmine.createSpyObj "authenticationService", ["isAuthenticated", "isAdmin", "authenticate"]

    authenticationService.authenticate.and.callFake -> then: (cb) -> cb()

    loginService = jasmine.createSpy()

    transitionService = toHome: jasmine.createSpy()

  describe "going to home", ->

    beforeEach ->
      authenticationService.isAuthenticated.and.callFake -> false

    it "should go home if current location is just the socket", ->

      $location.path.and.callFake -> ""

      homeController = tested $scope, $location, authenticationService, loginService, transitionService

      expect(transitionService.toHome).toHaveBeenCalled()

    it "should open login dialog if current path is under restriction", ->

      $location.path.and.callFake -> "/order"

      homeController = tested $scope, $location, authenticationService, loginService, transitionService

      expect(transitionService.toHome).not.toHaveBeenCalled()

      expect(loginService).toHaveBeenCalledWith {}, close: transitionService.toHome, cancel: transitionService.toHome

    it "should open login dialog if changed path is under restriction", ->

      $location.path.and.callFake -> "/order"

      $scope.$on.and.callFake (event, cb) -> cb()

      homeController = tested $scope, $location, authenticationService, loginService, transitionService

      expect(loginService).toHaveBeenCalled()

  describe "not going to home", ->

    beforeEach -> $location.path.and.callFake -> "/contacts"

    it "shouldn't open login dialog if current path isn't under restriction", ->

      homeController = tested $scope, $location, authenticationService, loginService, transitionService

      expect(loginService).not.toHaveBeenCalled()

    it "should set admin if user is authenticated", ->

      authenticationService.isAdmin.and.callFake -> true

      authenticationService.isAuthenticated.and.callFake -> true

      homeController = tested $scope, $location, authenticationService, loginService, transitionService

      expect(homeController.admin).toBe true

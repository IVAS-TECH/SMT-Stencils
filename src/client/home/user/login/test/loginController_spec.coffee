describe "loginController", ->

  tested = require "./../loginController"

  hide = loginController = RESTHelperService = undefined

  beforeEach ->

    RESTHelperService = login: login: jasmine.createSpy()

    hide = jasmine.createSpy()

    loginController = tested.call hide: hide, RESTHelperService

  describe "login", ->

    admin =
      admin: true
      access: 2

    user =
      email: "email@email"
      password: "password"

    it "shouldn't make request if for is invalid", ->

      loginController.login false

      expect(RESTHelperService.login.login).not.toHaveBeenCalled()

    it "should make a login if form is valid", ->

      RESTHelperService.login.login.and.callFake (obj, cb) ->
        cb login: true, admin: admin

      loginController.user = user

      loginController.login true

      expect(hide).toHaveBeenCalledWith
        login: null
        success:
          user: user
          session: true
          admin: admin

    it "should hide with 'fail'", ->

      RESTHelperService.login.login.and.callFake (obj, cb) ->
        cb login: false

      loginController.login true

      expect(hide).toHaveBeenCalledWith "fail"

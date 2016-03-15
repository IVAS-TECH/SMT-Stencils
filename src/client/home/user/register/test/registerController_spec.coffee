describe "registerController", ->

  tested = require "./../registerController"

  registerController = RESTHelperService = hide = undefined

  beforeEach ->

    RESTHelperService = user: register: jasmine.createSpy()

    RESTHelperService.user.register.and.callFake (obj, cb) -> cb()

    hide = jasmine.createSpy()

    registerController = tested.call hide: hide, RESTHelperService

  it "shouldn't register if it's invalid", ->

    registerController.register false

    expect(RESTHelperService.user.register).not.toHaveBeenCalled()

  it "should hide if successful register has been made", ->

    user =
      email: "email@email"
      password: "password"

    registerController.user = user

    registerController.register true

    expect(RESTHelperService.user.register).toHaveBeenCalledWith user: user, jasmine.any Function

    expect(hide).toHaveBeenCalledWith "success"

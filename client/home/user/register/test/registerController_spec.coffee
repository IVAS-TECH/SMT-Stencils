describe "registerController", ->

  tested = require "./../registerController"

  registerController = RESTHelperService = hide = undefined

  beforeEach ->

    RESTHelperService = register: jasmine.createSpy()

    RESTHelperService.register.and.callFake (obj, cb) -> cb()

    hide = jasmine.createSpy()

    registerController = tested.call hide: hide, RESTHelperService

  it "shouldn't register if it's invalid", ->

    registerController.register false

    expect(RESTHelperService.register).not.toHaveBeenCalled()

  it "should hide if successful register has been made", ->

    user =
      email: "email@email"
      password: "password"

    registerController.user = user

    registerController.register true

    expect(RESTHelperService.register).toHaveBeenCalledWith user: user, jasmine.any Function

    expect(hide).toHaveBeenCalledWith "success"

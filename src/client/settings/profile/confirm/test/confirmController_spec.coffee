describe "confirmController", ->

  tested = require "./../confirmController"

  confirmController = hide = undefined

  authenticationService =
    getUser: ->
      password: "password"

  beforeEach ->

    hide = jasmine.createSpy()

    confirmController = tested.call hide: hide, authenticationService

  it "shouldn't try to confirm if form is invalid", ->

    confirmController.confirm false

    expect(confirmController.hide).not.toHaveBeenCalled()

  it "should unconfirm if passwords doesn't match", ->

    confirmController.password = "passsword"

    confirmController.confirm true

    expect(confirmController.hide).toHaveBeenCalledWith "fail"

  it "should confirm if passwords match", ->

    confirmController.password = "password"

    confirmController.confirm true

    expect(confirmController.hide).toHaveBeenCalledWith "success"

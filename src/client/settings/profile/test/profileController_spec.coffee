describe "profileController", ->

  tested = require "./../profileController"

  event = {}

  profileController = confirmService = RESTHelperService = simpleDialogService = undefined

  showErrorService = ->

  beforeEach ->

    confirmService = jasmine.createSpy()

    confirmService.and.callFake (evnt, extnd) ->
      extnd.success()

    RESTHelperService = user: profile: jasmine.createSpy()

    RESTHelperService.user.profile.and.callFake (obj, cb) -> cb()

    simpleDialogService = jasmine.createSpy()

    profileController = tested.call {}, showErrorService, confirmService, RESTHelperService, simpleDialogService

  it "shouldn't change profile's email if form is invalid", ->

    profileController.change event, "email", false

    expect(confirmService).not.toHaveBeenCalled()

  it "should change profile's password if form is valid", ->

    profileController.user = password: "password"

    profileController.change event, "password", true

    expect(confirmService).toHaveBeenCalledWith event, success: jasmine.any Function

    expect(RESTHelperService.user.profile).toHaveBeenCalledWith type: "password", value: "password", jasmine.any Function

    expect(simpleDialogService).toHaveBeenCalledWith event, "title-changed-password"

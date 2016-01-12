describe "loginService", ->

  tested = require "./../loginService"

  loginService = showDialogService = authenticationService = tryAgainService = undefined

  handle =
    success: jasmine.any Function
    fail: jasmine.any Function

  beforeEach ->

    showDialogService = showDialog: jasmine.createSpy()

    authenticationService = authenticate: jasmine.createSpy()

    tryAgainService = jasmine.createSpy()

    loginService = tested showDialogService, authenticationService, tryAgainService

  it "should make a proper call to showDialog", ->

    event = {}

    extend = {}

    loginService event, extend

    expect(showDialogService.showDialog).toHaveBeenCalledWith event, "login", {}, handle, extend

  describe "handle.success", ->

    auth = {}

    it "should authenticate", ->

      showDialogService.showDialog.and.callFake (evnt, dlg, lcls, hndl, extnd) ->
        hndl.success auth

      loginService()

      expect(authenticationService.authenticate).toHaveBeenCalledWith auth

    describe "handle.success", ->

      event = {}

      beforeEach ->

        showDialogService.showDialog.and.callFake (evnt, dlg, lcls, hndl, xtnd) ->
          hndl.fail()

      it "should create a tryAgain dialog", ->

        loginService event

        expect(tryAgainService).toHaveBeenCalledWith event, "title-wrong-login", success: jasmine.any Function

      it "should make a recursive return", ->

        extend = {}

        tryAgainService.and.callFake (evnt, title, extnd) ->

          showDialogService.showDialog.and.stub()

          extnd.success()

        loginService event, extend

        expect(showDialogService.showDialog).toHaveBeenCalledWith event, "login", {}, handle, extend

        expect(showDialogService.showDialog.calls.count()).toEqual 2

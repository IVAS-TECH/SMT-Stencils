describe "circularDialogService", ->

  tested = require "./../circularDialogService"

  circularDialogService = showDialogService = tryAgainService = undefined

  event = {}

  locals = {}

  extend = {}

  beforeEach ->

    showDialogService = showDialog: jasmine.createSpy()

    tryAgainService = jasmine.createSpy()

    circularDialogService = tested showDialogService, tryAgainService

  it "should make a proper call to showDialog", ->

    handle =
      success: undefined
      fail: jasmine.any Function

    dialogService = circularDialogService "dialog", "wrong"

    dialogService event, extend

    expect(showDialogService.showDialog).toHaveBeenCalledWith event, "dialog", locals, handle, extend

  describe "handling", ->

    handle = spy = dialogService = undefined

    beforeEach ->

      spy = jasmine.createSpy()

      handle =
        success: spy
        fail: jasmine.any Function

      dialogService = circularDialogService "dialog", "wrong", spy

    describe "handle.success", ->

      arg = {}

      beforeEach ->

        showDialogService.showDialog.and.callFake (evnt, dlg, lcls, hndl, xtnd) ->
          hndl.success arg

      it "should call provided on success function", ->

        dialogService event

        expect(spy).toHaveBeenCalledWith arg

    describe "handle.fail", ->

      beforeEach ->

        showDialogService.showDialog.and.callFake (evnt, dlg, lcls, hndl, xtnd) ->
          hndl.fail()

      it "should create a tryAgain dialog", ->

        dialogService event

        expect(spy).not.toHaveBeenCalled()

        expect(tryAgainService).toHaveBeenCalledWith event, "title-wrong-wrong", success: jasmine.any Function

      it "should make a recursive return", ->

        tryAgainService.and.callFake (evnt, title, extnd) ->

          showDialogService.showDialog.and.stub()

          extnd.success()

        dialogService event, extend

        expect(showDialogService.showDialog).toHaveBeenCalledWith event, "dialog", locals, handle, extend

        expect(showDialogService.showDialog.calls.count()).toEqual 2

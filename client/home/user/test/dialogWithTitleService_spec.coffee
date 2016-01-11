describe "dialogWithTitleService", ->

  tested = require "./../dialogWithTitleService"

  event = {}

  title = "title"

  extend = {}

  it "should return function for creating new dialog service", ->

    showDialogService = showDialog: jasmine.createSpy()

    dialogWithTitleService = tested showDialogService

    dialogService = dialogWithTitleService "dialog"

    dialogService event, title, extend

    expect(showDialogService.showDialog)
      .toHaveBeenCalledWith event, "dialog", title: title, {}, extend

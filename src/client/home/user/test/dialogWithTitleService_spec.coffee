describe "dialogWithTitleService", ->

  tested = require "./../dialogWithTitleService"

  event = {}

  title = "title"

  extend = {}

  it "should return function for creating new dialog service", ->

    showDialogService = jasmine.createSpy()

    dialogWithTitleService = tested showDialogService

    dialogService = dialogWithTitleService "dialog"

    dialogService event, title, extend

    expect(showDialogService)
      .toHaveBeenCalledWith event, "dialog", title: title, {}, extend

describe "showDialogService", ->

  tested = require "./../showDialogService"

  showDialogService = undefined

  template = -> "html"

  describe "showing", ->

    show = jasmine.createSpy()

    show.and.callFake ->

      then: (resolve) ->

        resolve "action"

    hide = ->

    showDialogService = tested show: show, hide: hide, template

    it "should open dialog", ->

      showDialogService.showDialog {}, "test", {}

      expect(show).toHaveBeenCalledWith
        template: "html"
        targetEvent: undefined
        controller: "testController"
        controllerAs: "testCtrl"
        bindToController: true
        locals: hide: hide
        openFrom: "body"
        closeFrom: "body"
        escapeToClose: false

      event = target: {}

      showDialogService.showDialog event, "test", {}

      expect(show).toHaveBeenCalledWith
        template: "html"
        targetEvent: event
        controller: "testController"
        controllerAs: "testCtrl"
        bindToController: true
        locals: hide: hide
        openFrom: "body"
        closeFrom: "body"
        escapeToClose: false

describe "showDialogService", ->

  tested = require "./../showDialogService"

  show = showDialogService = undefined

  template = -> "html"

  hide = ->

  showErrorService = ->

  describe "showing and hiding without object", ->

    beforeEach ->

      show = jasmine.createSpy()

      show.and.callFake ->

        then: (resolve) ->

          resolve "action"

      $mdDialog =
        show: show
        hide: hide

      showDialogService = tested $mdDialog, showErrorService, template

    describe "showing", ->

      it "should open dialog", ->

        showDialogService.showDialog {}, "test", {}

        expect(show).toHaveBeenCalledWith
          template: "html"
          targetEvent: undefined
          controller: "testController"
          controllerAs: "testCtrl"
          bindToController: yes
          locals:
            hide: hide
            error: showErrorService
          openFrom: "body"
          closeFrom: "body"
          escapeToClose: no

        event = target: {}

        showDialogService.showDialog event, "test", {}

        expect(show).toHaveBeenCalledWith
          template: "html"
          targetEvent: event
          controller: "testController"
          controllerAs: "testCtrl"
          bindToController: yes
          locals:
            hide: hide
            error: showErrorService
          openFrom: "body"
          closeFrom: "body"
          escapeToClose: no

    describe "hiding without object", ->

      it "hides with single action passed from handle", ->

        spy = jasmine.createSpy()

        showDialogService.showDialog {}, "test", {}, "action": spy

        expect(spy).toHaveBeenCalled()

      it "hides with single action passed from extend", ->

        spy = jasmine.createSpy()

        showDialogService.showDialog {}, "test", {}, {}, "action": spy

        expect(spy).toHaveBeenCalled()

  describe "hiding with object", ->

    beforeEach ->

      show = jasmine.createSpy()

      show.and.callFake ->

        then: (resolve) ->

          resolve
            "action1": "val1"
            "action2": "val2"

      showDialogService = tested show: show, hide: hide, showErrorService, template

    it "hides with single action passed from extend", ->

      handle = undefined

      handle = jasmine.createSpyObj "handle", ["action1", "action2"]

      showDialogService.showDialog {}, "test", {}, handle

      expect(handle.action1).toHaveBeenCalledWith "val1"

      expect(handle.action2).toHaveBeenCalledWith "val2"

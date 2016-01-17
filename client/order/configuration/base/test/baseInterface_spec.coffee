describe "baseInterface", ->

  tested = require "./../baseInterface"

  baseInterface = $scope = RESTHelperService = simpleDialogService = progressService = confirmService = settings = undefined

  link = "test"

  event = {}

  beforeEach ->

    $scope = jasmine.createSpyObj "$scope", ["$digest", "$on"]

    test = jasmine.createSpyObj link, ["find", "create", "delete", "update"]

    RESTHelperService = test: test

    simpleDialogService = jasmine.createSpy()

    progressService = jasmine.createSpy()

    confirmService = jasmine.createSpy()

  describe "when settings is true", ->

    settings = yes

    beforeEach ->

      baseInterface = tested.call {}, $scope, RESTHelperService, simpleDialogService, progressService, confirmService, link, settings

    describe "once instanced", ->

      properties = ["Object", "List", "Index", "Action", "Disabled", "restore", "next", "back"]

      it "not supposed to call progressService", ->

        expect(progressService).not.toHaveBeenCalled()

        expect(baseInterface.link).toEqual link

        expect(baseInterface.settings).toBe settings

        expect(baseInterface.template).toEqual "testPanelView"

        expect(baseInterface.valid).toEqual []

        expect(baseInterface.common).toEqual properties[0..4]

        expect(baseInterface.choose).toEqual jasmine.any Function

        expect(baseInterface).toEqual jasmine.objectContaining
          edit: jasmine.any Function
          delete: jasmine.any Function
          update: jasmine.any Function
          doAction: jasmine.any Function

        test = (prop) ->

          expect(baseInterface[link + prop]).toBeUndefined()

        test property for property in properties

    describe "getObjects", ->

      list = [{}, {}, {}]

      res = testList: list

      beforeEach ->

        RESTHelperService.test.find.and.callFake (cb) ->
          cb res

      it "should fetch all DB Objects from server and store them in #{link}List", ->

        baseInterface.getObjects()

        expect(baseInterface.testList).toEqual list


    describe "reset", ->

      it "should reset view 'state'", ->

        spyOn baseInterface, "change"

        baseInterface.reset()

        expect(baseInterface.testDisabled).toBe no

        expect(baseInterface.testAction).toEqual "create"

        expect(baseInterface.testIndex).toBeUndefined()

        expect(baseInterface.testObject).toEqual {}

        expect(baseInterface.change).toHaveBeenCalled()

    describe "change", ->

      it "shouldn't do anything", ->

        {angular} = require "dependencies"

        beforeState = angular.copy baseInterface

        baseInterface.change()

        expect(baseInterface).toEqual beforeState

    describe "preview", ->

      it "should disable object view and set action to 'preview'", ->

        baseInterface.preview()

        expect(baseInterface.testDisabled).toBe yes

        expect(baseInterface.testAction).toEqual "preview"

    describe "choose", ->

      it "should set object view to match selected one", ->

        list = [{}, {}]

        baseInterface.testList = list

        baseInterface.testIndex = 1

        spyOn baseInterface, "preview"

        spyOn baseInterface, "change"

        baseInterface.choose()

        expect(baseInterface.preview).toHaveBeenCalled()

        expect(baseInterface.testObject).toEqual list[1]

        expect(baseInterface.change).toHaveBeenCalled()

    describe "isValid", ->

      resolve = reject = undefined

      beforeEach ->

        resolve = jasmine.createSpy()

        reject = jasmine.createSpy()

      it "should call rejected cb if some element in ::valid is falsly and call simpleDialogService", ->

        baseInterface.valid = [yes, no, yes]

        baseInterface.isValid event, resolve, reject

        expect(reject).toHaveBeenCalled()

        expect(resolve).not.toHaveBeenCalled()

        expect(simpleDialogService).toHaveBeenCalledWith event, "required-fields"

      it "should reject and if name is undefined or empty String", ->

        baseInterface.valid = [yes]

        baseInterface.testObject = name: ""

        baseInterface.isValid event, resolve, reject

        expect(reject).toHaveBeenCalled()

      it "should call resolved cb if is valid", ->

        baseInterface.valid = [yes]

        baseInterface.testObject = name: "name"

        baseInterface.isValid event, resolve, reject

        expect(resolve).toHaveBeenCalled()

        expect(reject).not.toHaveBeenCalled()

    describe "save", ->

      obj = name: "name"

      beforeEach ->

        RESTHelperService.test.create.and.callFake (send, cb) -> cb()

      it "should save view Object to db and update objectList in case of posible state back", (done) ->

        baseInterface.testObject = obj

        baseInterface.valid = [yes]

        baseInterface.testList = [{}]

        spyOn baseInterface, "isValid"

        baseInterface.isValid.and.callThrough()

        baseInterface.save(event).then ->

          expect(baseInterface.isValid).toHaveBeenCalled()

          expect(RESTHelperService.test.create).toHaveBeenCalledWith test: obj, jasmine.any Function

          expect(baseInterface.testList).toEqual [{}, obj]

          expect(baseInterface.testIndex).toEqual 1

          done()

    describe "edit", ->

      it "should undisable view and set action to 'edit'", ->

        baseInterface.edit()

        expect(baseInterface.testDisabled).toBe no

        expect(baseInterface.testAction).toEqual "edit"

    describe "delete and update", ->

      beforeEach ->

        confirmService.and.callFake (event, handle) ->
          handle.success()

      describe "delete", ->

        id = "id"

        obj = _id: id

        beforeEach ->

          RESTHelperService.test.delete.and.callFake (id, cb) -> cb()

        it "should delete the selected object but first will ask for confirmation", ->

          baseInterface.testObject = obj

          baseInterface.testList = [obj]

          spyOn baseInterface, "reset"

          baseInterface.delete event

          expect(baseInterface.testList).toEqual []

          expect(baseInterface.reset).toHaveBeenCalled()

          expect($scope.$digest).toHaveBeenCalled()

      describe "update", ->

        beforeEach ->

          RESTHelperService.test.update.and.callFake (send, cb) -> cb()

        it "should update view Object if it's valid", ->

          spyOn baseInterface, "isValid"

          spyOn baseInterface, "preview"

          baseInterface.isValid.and.callFake (evnt, cb) -> cb()

          baseInterface.update event

          expect(baseInterface.preview).toHaveBeenCalled()

          expect($scope.$digest).toHaveBeenCalled()

    describe "doAction", ->

      it "should call ::save if action is 'create'", ->

        spyOn baseInterface, "save"

        baseInterface.testAction = "create"

        baseInterface.doAction event

        expect(baseInterface.save).toHaveBeenCalledWith event


      it "should call ::update if action is 'edit'", ->

        spyOn baseInterface, "update"

        baseInterface.testAction = "edit"

        baseInterface.doAction event

        expect(baseInterface.update).toHaveBeenCalledWith event

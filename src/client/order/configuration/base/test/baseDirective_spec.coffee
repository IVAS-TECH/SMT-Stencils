describe "baseDirective", ->

    tested = require "./../baseDirective"

    controller = undefined

    baseDirective = tested ->

    beforeEach ->

      controller = jasmine.createSpyObj "controller", ["getObjects", "restore"]

    describe "when settings is false", ->

      it "should call controller.restore", ->

        controller.settings = no

        baseDirective.link {}, {}, {}, controller

        expect(controller.restore).toHaveBeenCalled()

        expect(controller.getObjects).not.toHaveBeenCalled()

    describe "when settinfs is true", ->

      it "should call controller.getObjects", ->

        controller.settings = yes

        baseDirective.link {}, {}, {}, controller

        expect(controller.getObjects).toHaveBeenCalled()

        expect(controller.restore).not.toHaveBeenCalled()

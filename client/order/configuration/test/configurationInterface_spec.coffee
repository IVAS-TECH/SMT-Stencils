describe "configurationInterface", ->

  configurationInterface = stop = undefined

  svg = "svg"

  beforeEach ->

    $scope = $on: jasmine.createSpy()

    stop = jasmine.createSpy()

    $scope.$on.and.callFake (event, cb) ->
      if event is "config-validity"
        cb null, yes
        return stop
      else cb()

    $controller = jasmine.createSpy()

    $controller.and.callFake (instance, injectables) -> {}

    template = -> svg

    dependency = ->

    tested = require "./../configurationInterface"

    configurationInterface = tested.call settings: yes, $controller, template, $scope, dependency, dependency, dependency, dependency

  describe "when instanced", ->

    it "should listen for changes", ->

      expect(configurationInterface).toEqual jasmine.objectContaining
        valid: [yes]
        btnBack: no
        text: "Text"
        view: svg
        style: {}
        options:
          side: ["pcb-side", "squeegee-side"]
          textPosition: [
            "top-left"
            "top-right"
            "top-center"
            "bottom-left"
            "bottom-right"
            "bottom-center"
            "center-left"
            "center-right"
          ]
          textAngle: ["left", "right", "bottom", "top"]

      expect(stop).toHaveBeenCalled()

  describe "textAngle", ->

    tests = [
      {
        what: "doesn't contain 'center'"
        input: "top-left"
        expected: ["left", "right", "bottom", "top"]
      }
      {
        what: "containts 'center-'"
        input: "center-left"
        expected: ["left", "right"]
      }
      {
        what: "containts '-center'"
        input: "top-center"
        expected: ["bottom", "top"]
      }
    ]

    run = (test) ->

      it "should return #{JSON.stringify test.expected} when called with value that #{test.what}", ->

        expect(configurationInterface.textAngle test.input).toEqual test.expected

    run test for test in tests

  describe "changeStencilTransitioning", ->

    tests = [
      {
        what: "::stencil object is undefined"
        tested: {}
        expected: no
      }
      {
        what: "::stencil::transitioning dose not match 'frame'"
        tested: stencil: transitioning: "rectangular"
        expected: no
      }
      {
        what: "::stencil::transitioning matches 'frame'"
        tested: stencil: transitioning: "glued-in-frame"
        expected: yes
      }
    ]

    run = (test) ->

      it "should set this::style::frame to #{test.expected} when this#{test.what}", ->

        configurationInterface.configurationObject = test.tested

        configurationInterface.changeStencilTransitioning()

        expect(configurationInterface.style.frame).toBe test.expected

    run test for test in tests

  describe "changeText", ->

    tests = [
      {
          text: undefined
          expected: ["pcb-side", "text-top-left-left"]
      }
      {
          text:
            type: "engraved"
            side: "squeegee-side"
          expected: ["squeegee-side", "text-top-left-left"]
      }
      {
          text:
            type: "drilled"
          expected: ["drilled", "text-top-left-left"]
      }
      {
          text:
            type: "drilled"
            position: "center-left"
          expected: ["drilled", "text-center-left-left"]
      }
      {
          text:
            type: "engraved"
            side: "squeegee-side"
            position: "top-center"
            angle: "top"
          expected: ["squeegee-side", "text-top-center-top"]
      }
      {
          text:
            type: "engraved"
            side: "pcb-side"
            position: "bottom-center"
            angle: "left"
          expected: ["pcb-side", "text-bottom-center-bottom"]
      }
    ]

    run = (test) ->

      it "should return 2 css classes for text preview -> #{test.expected.toString()} when text is #{JSON.stringify test.text}", ->

        if test.text?
          configurationInterface.options.textAngle = configurationInterface.textAngle(test.text.position)

        expect(configurationInterface.changeText test.text).toEqual test.expected

    run test for test in tests

  describe "changeStencilPosition", ->

    tests = [
      {
        what: "this::configurationObject::osition is undefined"
        position: undefined
        style:
          outline: no
          layout: no
          mode: "portrait-centered"
      }
      {
        what: "this::configurationObject::position::position is 'like-layout-file' and aligment is undefined"
        position:
          position: "like-layout-file"
        style:
          outline: no
          layout: no
          mode: "portrait-no"
      }
      {
        what: "this::configurationObject::position::position is 'layout-centered' and aligment is 'landscape'"
        position:
          position: "layout-centered"
          aligment: "landscape"
        style:
          outline: no
          layout: yes
          mode: "landscape-centered"
      }
      {
        what: "this::configurationObject::position::position is 'pcb-centered' and layout is 'portrait'"
        position:
          position: "pcb-centered"
          aligment: "portrait"
        style:
          outline: yes
          layout: no
          mode: "portrait-centered"
      }
      {
        what: "this::configurationObject::position::position is 'pcb-centered' and layout is 'landscape'"
        position:
          position: "pcb-centered"
          aligment: "landscape"
        style:
          outline: yes
          layout: no
          mode: "landscape-centered"
      }
    ]

    run = (test) ->

      it "should set this::style to #{JSON.stringify test.style} when #{test.what}", ->

        configurationInterface.configurationObject = position: test.position

        configurationInterface.changeStencilPosition()

        expect(configurationInterface.style).toEqual test.style

    run test for test in tests

  describe "change", ->

    beforeEach ->

      spyOn configurationInterface, func for func in ["textAngle", "changeText", "changeStencilTransitioning", "changeStencilPosition"]

    it "should change configuration view to state of new configuration", ->

      configurationInterface.configurationObject = {}

      configurationInterface.change()

      expect(configurationInterface.textAngle).toHaveBeenCalledWith ""

      expect(configurationInterface.changeText).toHaveBeenCalledWith undefined

      expect(configurationInterface.changeStencilPosition).toHaveBeenCalled()

      expect(configurationInterface.changeStencilTransitioning).toHaveBeenCalled()

    it "should change configuration view to slected configuration", ->

      position = "center-left"

      text = position: position

      configurationInterface.configurationObject = text: text

      configurationInterface.change()

      expect(configurationInterface.textAngle).toHaveBeenCalledWith position

      expect(configurationInterface.changeText).toHaveBeenCalledWith text

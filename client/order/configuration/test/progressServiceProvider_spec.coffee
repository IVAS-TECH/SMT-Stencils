describe "progressServiceProvider", ->

  tested = require "./../progressServiceProvider"

  restored = scope = progressService = $state = undefined

  progressServiceProvider = tested()

  state = "parentState"

  move = ["state1", "state2", "state3"]

  beforeEach ->

    $state =
      current: name: move[1]
      go: jasmine.createSpy()

    progressServiceProvider.setState state

    progressServiceProvider.setMove move

    progressService = progressServiceProvider.$get $state

    scope = jasmine.createSpyObj "scope", ["$watch", "$emit"]

    restored = jasmine.createSpy()

  describe "when current state is visited for first time", ->

    progress = undefined

    childCtrl =
      prop1: "val1"
      prop2: "val2"
      prop3: "val3"

    parentCtrl = prop0: "val0"

    beforeEach (done) ->

      scope.$watch.and.callFake (event, cb) ->

        simulate = ->

          cb {}

          done()

        setTimeout simulate, 1
        
        restored

      scope.childCtrl = childCtrl

      scope.$parent = parentCtrl: parentCtrl

      progress = progressService scope, "parentCtrl", "childCtrl"

    it "shouldn't change controller just save properties names", ->

      expect(restored).toHaveBeenCalled()

      expect(scope.$emit).not.toHaveBeenCalled()

      expect(scope.childCtrl).toEqual childCtrl

      expect(scope.$parent.parentCtrl).toEqual parentCtrl

    it "should change state to next in move and copy all properties to parentCtrl", ->

      progress yes

      expect(scope.childCtrl).toEqual childCtrl

      expected = {}

      expected["prop" + i] = "val" + i for i in [0..3]

      expect(scope.$parent.parentCtrl).toEqual expected

      expect($state.go).toHaveBeenCalledWith "#{state}.#{move[2]}"

    it "should change state to previus if called with falsly value", ->

      progress()

      expect($state.go).toHaveBeenCalledWith "#{state}.#{move[0]}"

  describe "when current state is visited not for first time", ->

    progress = undefined

    childCtrl =
      prop1: "init1"
      prop2: "init2"
      prop3: "init3"

    parentCtrl =
      prop0: "val0"
      prop1: "val1"
      prop2: "val2"
      prop3: "val3"
      prop4: "val4"

    beforeEach ->

      scope.childCtrl = childCtrl

      scope.$parent = parentCtrl: parentCtrl

    it "should restore controller's state acordinglly to exclude and awaiting values", (done) ->

      expected = {}

      expected["prop" + i] = "val" + i for i in [2..4]

      expected.prop1 = "init1"

      scope.$watch.and.callFake (event, cb) ->

        simulate = ->

          cb {}

          expect(scope.childCtrl).toEqual expected

          done()

        setTimeout simulate, 1

        restored

      expect(scope.childCtrl).toEqual childCtrl

      progressService scope, "parentCtrl", "childCtrl", ["prop1"], ["prop4"]

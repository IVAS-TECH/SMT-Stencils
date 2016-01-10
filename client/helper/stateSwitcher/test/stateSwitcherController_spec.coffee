describe "stateSwitcherController", ->

  tested = require "./../stateSwitcherController"

  $ = $scope = $state = undefined

  beforeEach ->

    $scope = $on: jasmine.createSpy()

    $state =

      go: jasmine.createSpy()

      current: name: "home.about"

      get: ->
        states = [
          {name: "home"}
          {name: "home.about"}
          {name: "home.order"}
          {name: "home.admin"}
          {name: "home.settings"}
          {name: "home.settings.profile"}
        ]
        for state in states
          state.abstract = false
        states

    $ =
      state: "home"
      remove: ["admin"]
      override:
        order: "configuration"
        settings: "profile"

  describe "bindings", ->

    it "should have override = {} and remove = []", ->

      delete $.remove
      delete $.override

      stateCtrl = tested.call $, $scope, $state

      expect(stateCtrl.override).toEqual {}

      expect(stateCtrl.remove).toEqual []

    it "should have override and remove bound ot it", ->

      stateCtrl = tested.call $, $scope, $state

      expect(stateCtrl.override).toEqual $.override

      expect(stateCtrl.remove).toEqual $.remove

  describe "controller", ->

    it "sould have everything set", ->

      stateCtrl = tested.call $, $scope, $state

      expect(stateCtrl.selected).toEqual [true, false, false]

      expect(stateCtrl.states).toEqual ["about", "order", "settings"]

    describe "controller.switchState", ->

      it "should change $state", ->

        stateCtrl = tested.call $, $scope, $state

        stateCtrl.switchState "order"

        expect($state.go).toHaveBeenCalledWith "home.order"

    describe "listening for $state change", ->

      it "should override current state", ->

        $scope.$on.and.callFake (eventType, callback) ->

          callback {}, name: "home.settings"

        stateCtrl = tested.call $, $scope, $state

        stateCtrl.switchState "settings"

        expect($state.go).toHaveBeenCalledWith "home.settings.profile"

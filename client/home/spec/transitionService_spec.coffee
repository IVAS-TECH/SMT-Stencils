mock = require "mock"

describe "goHomeService", ->

  transitionService = $state = undefined

  beforeEach mock.module "main"

  beforeEach mock.inject (_transitionService_, _$state_) ->
    $state = _$state_
    transitionService = _transitionService_

  tests = [
    {
      method: "toHome"
      expect: "home.about"
    }
      {
        method: "toAdmin"
        expect: "home.admin"
      }
  ]

  for test in tests

    it "should chage $state to #{test.expect}", () ->

      spyOn($state, "go").and.callFake (transition) ->
        $state.current.name = test.expect

      expect($state.current.name).not.toEqual test.expect

      transitionService[test.method]()

      expect($state.go).toHaveBeenCalledWith test.expect

      expect($state.current.name).toEqual test.expect

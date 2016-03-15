tested = require "./../transitionService"

describe "goHomeService", ->

  transitionService = $state = undefined

  beforeEach ->
    $state =
      current: name: ""
      go: ->

    transitionService = tested $state

  tests = [
    {
      expect: "home.about"
      tested: "toHome"
    }
    {
      expect: "home.admin"
      tested: "toAdmin"
    }
  ]

  run = (test) ->

    it "should chage $state to #{test.expect}", () ->

      spyOn($state, "go").and.callFake (transition) ->
        $state.current.name = test.expect

      expect($state.current.name).not.toEqual test.expect

      transitionService[test.tested]()

      expect($state.go).toHaveBeenCalledWith test.expect

  run test for test in tests
